export type ComplianceStatus = 'approved' | 'flagged' | 'unknown';

export interface ComplianceResult {
  packageName: string;
  license: string;
  status: ComplianceStatus;
  message: string;
}

const APPROVED_LICENSES = ['MIT', 'Apache-2.0', 'BSD-2-Clause', 'BSD-3-Clause', 'ISC'];
const FLAGGED_LICENSES = ['GPL-2.0', 'GPL-3.0', 'AGPL-3.0', 'LGPL-2.1'];

export class LicenseChecker {
  private approvedLicenses: string[];
  private flaggedLicenses: string[];

  constructor() {
    this.approvedLicenses = [...APPROVED_LICENSES];
    this.flaggedLicenses = [...FLAGGED_LICENSES];
  }

  check(packageName: string, license: string): ComplianceResult {
    if (this.approvedLicenses.includes(license)) {
      return {
        packageName,
        license,
        status: 'approved',
        message: `License ${license} is approved for use.`,
      };
    }
    if (this.flaggedLicenses.includes(license)) {
      return {
        packageName,
        license,
        status: 'flagged',
        message: `License ${license} requires legal review before use.`,
      };
    }
    return {
      packageName,
      license,
      status: 'unknown',
      message: `License ${license} is not recognized. Manual review required.`,
    };
  }

  isApproved(license: string): boolean {
    return this.approvedLicenses.includes(license);
  }

  getApprovedLicenses(): string[] {
    return [...this.approvedLicenses];
  }
}
