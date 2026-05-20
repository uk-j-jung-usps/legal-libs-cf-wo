# Code Flow Documentation: `new.master.file.detail.display.dct.cfm`

## Overview

This document describes the complete code flow for the **District Court (DCT) Master File Detail Display** page in the Legal Libs ColdFusion application. This page is the primary data-entry form for District Court cases (matter_type_key = 5) in the Western Operations (WO) office.

---

## 1. Entry Points — How the User Reaches This Page

There are **two entry paths** that route the user to `new.master.file.detail.display.dct.cfm`:

### Path A: Via `new.lm_matter_no.cfm` (Matter Number Lookup)

| Step | Description |
|------|-------------|
| 1 | User submits a matter number via a form on `new.case.files.home.cfm`. |
| 2 | `new.lm_matter_no.cfm` receives `form.matter_no`, extracts the user's ACE ID from `AUTH_USER`. |
| 3 | Instantiates `components.wo_eeoc_component` and calls `qryMatterNo(matterNumber)` to look up the matter in LawManager. |
| 4 | If no record is found → redirects back to `new.case.files.home.cfm?matternoerror=Y`. |
| 5 | Extracts `matter_key`, `matter_type_key`, and `matter_prefix` from the query result. |
| 6 | Builds query strings via `woComponent.buildQS(...)`. |
| 7 | Routes by `matter_type_key`: for **case 5 (District Court)** with prefix **SF or WO** (default) → redirects to: `new.master.file.detail.display.dct.cfm?matterkey=X&matternumber=Y&mattertypekey=5` |

### Path B: Via `new.case.files.home.cfm` (Direct Link with matterkey in URL)

| Step | Description |
|------|-------------|
| 1 | User clicks a direct link that already has `url.matterkey` populated. |
| 2 | Page queries LawManager for the matter, then uses a `<cfswitch>` on `matter_type_key`. |
| 3 | For **case value="5"** with prefix SF or WO → `<cflocation>` to `new.master.file.detail.display.dct.cfm?...`. |

---

## 2. Page Initialization (Lines 1–22)

Once the browser arrives at `new.master.file.detail.display.dct.cfm`, the following initialization occurs:

### 2.1 Helper Function Definition (Lines 1–7)

```coldfusion
function renderOption(value, currentValue = "") {
    var isSelected = (len(trim(arguments.currentValue)) && trim(arguments.currentValue) EQ trim(arguments.value))
        ? ' selected="selected"' : '';
    return '<option value="...">...</option>';
}
```

**Purpose:** Generates an HTML `<option>` element. If `currentValue` matches `value`, the option is marked `selected`. Used throughout the form to populate dropdown menus with pre-selected values.

### 2.2 Data Includes (Lines 9–12)

Four `<cfinclude>` templates are executed **in order**:

| # | Include File | Purpose |
|---|---|---|
| 1 | `new.submitted.data.dct.cfm` | Loads previously-saved form data for this matter from `cmft_matterkey_pairs` |
| 2 | `new.ausa.data.cfm` | Loads AUSA (Assistant US Attorney) info from LawManager |
| 3 | `new.plaintiff.data.cfm` | Loads Plaintiff info (name, address, SSN, docket #, defendant) from LawManager |
| 4 | `new.plaintiff.rep.data.cfm` | Loads Plaintiff Representative info from LawManager |

### 2.3 Variable Defaulting (Lines 14–21)

All form variables are defaulted to empty string (`""`) if not already set by the includes above. This ensures no undefined variable errors when rendering the form.

---

## 3. Include #1: `new.submitted.data.dct.cfm` — Load Previously Saved Data

**Purpose:** Retrieves the user's last-saved form submission for this matter so the form can be pre-populated.

### Flow:

1. **Query** `lawmanager.cmft_matterkey_pairs` WHERE `matter_key = url.matterkey`, ordered by `tempvar_key`.
2. **Map** each `tempvar_key` integer to a named variable using a struct (`tempvarMap`). Examples:
   - `"112"` → `case_no`
   - `"86"` → `plaintiff_fname`
   - `"94"` → `ausa_fname`
   - `"8"` → `attorney_name`
3. **Loop** through query results: for each row, if the `tempvar_key` exists in the map, set `variables[mappedName] = trimmed value`.
4. **Ensure** all mapped variables exist (even if not returned by query) by iterating the map and defaulting missing ones to `""`.

**Result:** After this include, variables like `plaintiff_fname`, `ausa_district`, `attorney_name`, etc. may already have values from the user's previous save.

---

## 4. Include #2: `new.ausa.data.cfm` — Load AUSA Data from LawManager

**Purpose:** Queries the AUSA (Assistant US Attorney) assigned to this matter.

### Flow:

1. **Query** joins `matter` → `matterentity` → `entity` WHERE `matter_key = url.matterkey` AND `matter_entity_type_key = 11` (AUSA role).
2. **If found:** Sets `ausa_fname`, `ausa_lname`, `ausa_title` from query results.
3. **If not found:** Sets all three to empty string.

**Note:** This may **overwrite** values previously loaded from `new.submitted.data.dct.cfm` with fresher data from LawManager.

---

## 5. Include #3: `new.plaintiff.data.cfm` — Load Plaintiff Data from LawManager

**Purpose:** Comprehensive plaintiff data loading with multiple queries and fallback logic.

### Flow:

#### 5.1 Plaintiff Name/EID/Facility/District Query
- Joins `matter` → `matterentity` → `entity` → `fncm` → `matterclientorgsusps`
- Filter: `matter_entity_type_key = 33` (Plaintiff role)
- Extracts: `first_name`, `last_name`, `plaintiff_eid`, `plaintiff_facility`, `plaintiff_district`

#### 5.2 Helper Function: `parseCityStZip(citystzip)`
- Parses a combined "City, ST Zip" string into individual `city`, `state`, `zip` components.
- Used as fallback when LawManager doesn't have separated address fields.

#### 5.3 Data Priority Logic
- **If plaintiff found in LM:**
  - Uses LM data for name, facility, district
  - EID: uses LM if available, else falls back to previously submitted data
- **If plaintiff NOT found in LM:**
  - Falls back to previously submitted data (parsing `plaintiff_citystzip`)
  - If no submitted data either → all fields default to `""`

#### 5.4 Plaintiff Address Query (conditional)
- Only runs if plaintiff was found in the first query
- Joins `entity` → `address` + `eaddress`
- For each field (street, city, state, zip, email): uses LM data if available → else parses submitted `citystzip` → else `""`

#### 5.5 Plaintiff SSN Query (conditional)
- Queries `lawmanager.hr.emp_xref` by `entity_key`
- Sets `plaintiff_ssn` if found

#### 5.6 Case Docket Number Query
- Queries `lawmanager.forum` WHERE `matter_key = url.matterkey` AND `venue_type_key IN (10,11,12,13)` AND `forum_type_key = 3`
- Sets `case_no` (court docket number)

#### 5.7 Defendant Name Query
- Joins `matter` → `matterentity` → `entity` WHERE `matter_entity_type_key = 36` (Defendant role)
- Sets `defendant_name`

---

## 6. Include #4: `new.plaintiff.rep.data.cfm` — Load Plaintiff Representative Data

**Purpose:** Loads attorney/representative information for the plaintiff's counsel.

### Flow:

#### 6.1 Plaintiff Rep Name Query
- Joins `matter` → `matterentity` → `entity` WHERE `matter_entity_type_key = 37`
- Extracts: `first_name`, `last_name`

#### 6.2 If Plaintiff Rep Found:

| Sub-Query | Purpose |
|---|---|
| Company Query | Queries `entity` WHERE `entity_type_key = 37` AND `person_company_flag = 'C'` to get company name |
| Address Query | Joins `entity` → `address` + `eaddress` for street, city, state, zip, email |
| Phone Query | Queries `phone` WHERE `phone_type_key IN (2,3,4,6)` |
| Fax Query | Queries `phone` WHERE `phone_type_key = 5` |

Each field uses the same priority: **LawManager data → previously submitted data → empty string**.

#### 6.3 If Plaintiff Rep NOT Found:
- Falls back to submitted `plaintiff_rep_citystzip` parsing or defaults all to `""`.

---

## 7. HTML Form Rendering (Lines 24–523)

After all data is loaded, the page renders an HTML form.

### 7.1 Page Structure

```
DOCTYPE html → <head> (CSS, title) → <body>
  └── <cfform action="save.input.data.cfm" method="post">
      ├── Hidden fields: matterkey, matternumber, mattertypekey
      └── <table> with form fields organized in two-column layout
```

### 7.2 Form Layout (Left Column / Right Column)

| Left Column (Tabs 1–31) | Right Column (Tabs 32–60) |
|---|---|
| Plaintiff EID | AUSA Prefix (Mr./Ms.) |
| Plaintiff SSN | AUSA First Name |
| Case Number | AUSA Last Name |
| Plaintiff First Name | AUSA Bar No. |
| Plaintiff Last Name | AUSA Title |
| Plaintiff Address | AUSA District (dropdown) |
| Plaintiff City/State/Zip | AUSA Address1 (dropdown) |
| Plaintiff Facility | AUSA Address2 (dropdown) |
| Plaintiff District | AUSA CityStZip (dropdown) |
| Plaintiff Email | AUSA Phone & Fax (dropdowns) |
| Defendant Name | AUSA Email |
| --- | AUSA Chief First Name (dropdown) |
| Plaintiff Rep First Name | AUSA Chief Last Name (dropdown) |
| Plaintiff Rep Last Name | US Attorney |
| Plaintiff Rep Company | --- |
| Plaintiff Rep Address | USDJ First Name |
| Plaintiff Rep City/State/Zip | USDJ Last Name |
| Plaintiff Rep Phone & Fax | USDJ Title |
| Plaintiff Rep Email | USDJ Address |
| --- | USDJ City/State/Zip |
| WO Office (dropdown) | USDJ Office |
| WO Address1 (dropdown) | USDJ Phone & Fax |
| WO Address2 (dropdown) | --- |
| WO Phone (dropdown) | LR Manager (DB dropdown) |
| WO Fax (dropdown) | HR Manager (DB dropdown) |
| Attorney (DB dropdown) | District Manager (DB dropdown) |
| Attorney Title (dropdown) | H&R Mgr - District (DB dropdown) |
| Paralegal (DB dropdown) | OHNA - District (DB dropdown) |

### 7.3 Dynamic Database Dropdowns (Inline Queries)

Six dropdowns are populated by **live queries** to `lawmanager.cmft_entity_wo`:

| Dropdown | Entity Role Filter | Query Name |
|---|---|---|
| LR Manager | `LRMGR` | `qry_lr_mgr` |
| HR Manager | `HRMGR` | `qry_hr_mgr` |
| Attorney | `ATTNY` | `qry_attorney` |
| District Manager | `DMGR` | `qry_dist_mgr` |
| H&R Mgr District | `HRDST` | `qry_hr_mgr_dist` |
| Paralegal | `PLGL` | `qry_paralgl` |
| OHNA District | `OHNA` | `qry_ohna_dist` |

All queries join `entity` → `cmft_entity_wo` WHERE `group_prefix = 'WO'`, ordered by `sort_fld`.

### 7.4 Static Dropdowns (Hardcoded Lists)

| Field | Values |
|---|---|
| AUSA District | Central District of California, District of Hawaii, Eastern/Northern/Southern District of California |
| AUSA Address1 | Federal Building locations |
| AUSA Address2 | Street addresses with suite numbers |
| AUSA CityStZip | San Francisco, Sacramento, Los Angeles, San Diego, Honolulu, Fresno |
| AUSA Phone/Fax | Various office numbers |
| WO Office | Denver, Long Beach, Salt Lake, San Diego, San Francisco, Seattle |
| WO Address1/2 | Corresponding office addresses |
| WO Phone/Fax | Office phone/fax numbers |
| Attorney Title | Attorney, Senior Litigation Counsel, Managing Counsel, Deputy Managing Counsel |
| AUSA Chief First/Last Name | Predefined lists of chief names |

### 7.5 Navigation Bar

Links at the top of the form:
- **Home** → `new.case.files.home.cfm`
- **LawManager** → External link to `lawdept2.usps.gov` (opens in new tab)
- **Legal Libs Admin** → `admin.pages.cfm`
- Label: "WLO - District Court"

---

## 8. Form Submission → `save.input.data.cfm`

When the user clicks "Save and Continue", the form POSTs to `save.input.data.cfm`.

### Flow:

| Step | Description |
|------|-------------|
| 1 | **Initialize:** Gets current date, extracts ACE ID from `AUTH_USER`. |
| 2 | **Get owner_key:** Queries `lawmanager.personnel` by `login_name` to get `personnel_key`. |
| 3 | **Check existing:** Queries `lawmanager.cmft_base` for `matter_key`. |
| 4a | **If first time:** Includes `process.cmft.base.cfm` to do initial insert into `cmft_base`. |
| 4b | **If exists:** Updates `cmft_base` (sets `process='Y'`, `updated_by`, `date_updated`), then **deletes** all rows from `cmft_selected_templates` and `cmft_matterkey_pairs` for this matter (to be replaced). |
| 5 | **Route by matter_type_key:** For **case 5 (District Court)** → includes `process.cmft.matterkey.pairs.dct.cfm` (inserts new key-value pairs into `cmft_matterkey_pairs`). |
| 6 | **Redirect:** Sends user to `template.list.display.cfm?matterkey=...&matternumber=...&mattertypekey=...&ownerkey=...` for template selection. |

---

## 9. Complete Flow Diagram

```
┌─────────────────────────────────────┐
│   new.case.files.home.cfm           │
│   (User enters matter number)       │
└──────────────┬──────────────────────┘
               │ POST form.matter_no
               ▼
┌─────────────────────────────────────┐
│   new.lm_matter_no.cfm             │
│   - Validates matter number         │
│   - Routes by matter_type_key       │
│   - For DCT (5) + WO/SF prefix:    │
└──────────────┬──────────────────────┘
               │ Redirect (302)
               ▼
┌══════════════════════════════════════════════════════════════════════┐
║   new.master.file.detail.display.dct.cfm                           ║
║                                                                      ║
║   ┌──────────────────────────────────────────────────────────────┐  ║
║   │ STEP 1: Define renderOption() helper                         │  ║
║   └──────────────────────────────────────────────────────────────┘  ║
║                              │                                       ║
║   ┌──────────────────────────▼───────────────────────────────────┐  ║
║   │ STEP 2: cfinclude "new.submitted.data.dct.cfm"               │  ║
║   │  → Query cmft_matterkey_pairs for saved data                 │  ║
║   │  → Map tempvar_keys to variable names                        │  ║
║   │  → Set variables from previous save                          │  ║
║   └──────────────────────────────────────────────────────────────┘  ║
║                              │                                       ║
║   ┌──────────────────────────▼───────────────────────────────────┐  ║
║   │ STEP 3: cfinclude "new.ausa.data.cfm"                        │  ║
║   │  → Query AUSA by matter_entity_type_key = 11                 │  ║
║   │  → Set ausa_fname, ausa_lname, ausa_title                   │  ║
║   └──────────────────────────────────────────────────────────────┘  ║
║                              │                                       ║
║   ┌──────────────────────────▼───────────────────────────────────┐  ║
║   │ STEP 4: cfinclude "new.plaintiff.data.cfm"                   │  ║
║   │  → Query Plaintiff (type 33): name, EID, facility, district  │  ║
║   │  → Query Plaintiff address & email                           │  ║
║   │  → Query Plaintiff SSN from hr.emp_xref                      │  ║
║   │  → Query Case docket number from forum table                 │  ║
║   │  → Query Defendant name (type 36)                            │  ║
║   └──────────────────────────────────────────────────────────────┘  ║
║                              │                                       ║
║   ┌──────────────────────────▼───────────────────────────────────┐  ║
║   │ STEP 5: cfinclude "new.plaintiff.rep.data.cfm"               │  ║
║   │  → Query Plaintiff Rep (type 37): name                       │  ║
║   │  → Query Rep company, address, phone, fax                    │  ║
║   └──────────────────────────────────────────────────────────────┘  ║
║                              │                                       ║
║   ┌──────────────────────────▼───────────────────────────────────┐  ║
║   │ STEP 6: Default all undefined variables to ""                │  ║
║   └──────────────────────────────────────────────────────────────┘  ║
║                              │                                       ║
║   ┌──────────────────────────▼───────────────────────────────────┐  ║
║   │ STEP 7: Render HTML form                                     │  ║
║   │  → 7 inline DB queries for role-based dropdowns              │  ║
║   │  → Static dropdowns for AUSA/WO office data                  │  ║
║   │  → All fields pre-populated with loaded values               │  ║
║   └──────────────────────────────────────────────────────────────┘  ║
╚══════════════════════════════════════════════════════════════════════╝
               │ User clicks "Save and Continue"
               │ POST to save.input.data.cfm
               ▼
┌─────────────────────────────────────┐
│   save.input.data.cfm               │
│   - Get personnel_key from ACE ID   │
│   - Insert/Update cmft_base         │
│   - Delete old pairs & templates    │
│   - Include process.cmft.           │
│     matterkey.pairs.dct.cfm         │
│   - Redirect to template list       │
└──────────────┬──────────────────────┘
               │ Redirect
               ▼
┌─────────────────────────────────────┐
│   template.list.display.cfm         │
│   (User selects document templates) │
└─────────────────────────────────────┘
```

---

## 10. Database Tables Referenced

| Table | Purpose |
|---|---|
| `lawmanager.matter` | Core matter/case record |
| `lawmanager.matterentity` | Links matters to entities (people/orgs) by role |
| `lawmanager.entity` | People and organizations |
| `lawmanager.address` | Physical addresses for entities |
| `lawmanager.eaddress` | Email addresses for entities |
| `lawmanager.phone` | Phone numbers for entities |
| `lawmanager.fncm` | Facility name cross-reference |
| `lawmanager.matterclientorgsusps` | USPS organizational hierarchy |
| `lawmanager.forum` | Court/forum and docket information |
| `lawmanager.hr.emp_xref` | Employee SSN cross-reference |
| `lawmanager.cmft_matterkey_pairs` | Saved template variable key-value pairs |
| `lawmanager.cmft_base` | Base record for template processing per matter |
| `lawmanager.cmft_selected_templates` | Which templates were selected for generation |
| `lawmanager.cmft_entity_wo` | WO office personnel by role (attorneys, paralegals, managers) |
| `lawmanager.personnel` | Application users (ACE ID → personnel_key) |

---

## 11. Data Priority/Override Logic

The system uses a **layered data loading** strategy:

```
Priority (highest wins):
  1. LawManager live data (from entity/matter queries)
  2. Previously submitted form data (from cmft_matterkey_pairs)
  3. Empty string default
```

This means fresh LawManager data always takes precedence, but if a field doesn't exist in LM, the user's last-saved value is preserved.

---

## 12. URL Parameters Required

| Parameter | Source | Description |
|---|---|---|
| `url.matterkey` | Router | Primary key for the matter in LawManager |
| `url.matternumber` | Router | Human-readable matter number (e.g., "WO-2024-00123") |
| `url.mattertypekey` | Router | Always `5` for District Court |

---

## 13. Security Considerations

- All URL parameters are encoded with `encodeForHTMLAttribute()` before rendering in hidden fields.
- The `renderOption()` helper uses `encodeForHTMLAttribute()` and `encodeForHTML()` for XSS protection.
- Database queries use `<cfqueryparam>` for SQL injection prevention.
- User identity is derived from `AUTH_USER` (IIS/Windows authentication).
