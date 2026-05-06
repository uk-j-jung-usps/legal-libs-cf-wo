import { LicenseChecker } from '../license-compliance';

describe('LicenseChecker', () => {
  let checker: LicenseChecker;

  beforeEach(() => {
    checker = new LicenseChecker();
  });

  describe('check', () => {
    it('returns approved for MIT', () => {
      const result = checker.check('some-pkg', 'MIT');
      expect(result.status).toBe('approved');
      expect(result.packageName).toBe('some-pkg');
      expect(result.license).toBe('MIT');
    });

    it('returns approved for Apache-2.0', () => {
      const result = checker.check('pkg', 'Apache-2.0');
      expect(result.status).toBe('approved');
    });

    it('returns approved for BSD-2-Clause', () => {
      expect(checker.check('pkg', 'BSD-2-Clause').status).toBe('approved');
    });

    it('returns approved for BSD-3-Clause', () => {
      expect(checker.check('pkg', 'BSD-3-Clause').status).toBe('approved');
    });

    it('returns approved for ISC', () => {
      expect(checker.check('pkg', 'ISC').status).toBe('approved');
    });

    it('returns flagged for GPL-2.0', () => {
      const result = checker.check('pkg', 'GPL-2.0');
      expect(result.status).toBe('flagged');
    });

    it('returns flagged for GPL-3.0', () => {
      expect(checker.check('pkg', 'GPL-3.0').status).toBe('flagged');
    });

    it('returns flagged for AGPL-3.0', () => {
      expect(checker.check('pkg', 'AGPL-3.0').status).toBe('flagged');
    });

    it('returns flagged for LGPL-2.1', () => {
      expect(checker.check('pkg', 'LGPL-2.1').status).toBe('flagged');
    });

    it('returns unknown for unrecognized license', () => {
      const result = checker.check('pkg', 'CUSTOM-1.0');
      expect(result.status).toBe('unknown');
    });

    it('includes package name in result', () => {
      const result = checker.check('my-package', 'MIT');
      expect(result.packageName).toBe('my-package');
    });
  });

  describe('isApproved', () => {
    it('returns true for MIT', () => {
      expect(checker.isApproved('MIT')).toBe(true);
    });

    it('returns false for GPL-2.0', () => {
      expect(checker.isApproved('GPL-2.0')).toBe(false);
    });

    it('returns false for unknown license', () => {
      expect(checker.isApproved('UNKNOWN')).toBe(false);
    });
  });

  describe('getApprovedLicenses', () => {
    it('returns array of approved licenses', () => {
      const licenses = checker.getApprovedLicenses();
      expect(licenses).toContain('MIT');
      expect(licenses).toContain('Apache-2.0');
      expect(licenses).toContain('BSD-2-Clause');
      expect(licenses).toContain('BSD-3-Clause');
      expect(licenses).toContain('ISC');
    });

    it('returns a copy (not the internal array)', () => {
      const licenses = checker.getApprovedLicenses();
      licenses.push('EVIL');
      expect(checker.getApprovedLicenses()).not.toContain('EVIL');
    });
  });
});
