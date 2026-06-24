import { ComplianceReportGenerator, ReportData } from '../compliance-report';

describe('ComplianceReportGenerator', () => {
  let generator: ComplianceReportGenerator;
  const scanDate = new Date('2024-01-15T00:00:00Z');

  const reportData: ReportData = {
    projectName: 'TestProject',
    version: '1.0.0',
    scanDate,
    packages: [
      { name: 'lodash', version: '4.17.21', license: 'MIT' },
      { name: 'left-pad', version: '1.3.0', license: 'BSD-3-Clause' },
      { name: 'some-gpl-lib', version: '2.0.0', license: 'GPL-2.0' },
      { name: 'weird-lib', version: '0.1.0', license: 'CUSTOM-1.0' },
    ],
  };

  beforeEach(() => {
    generator = new ComplianceReportGenerator();
  });

  describe('generate', () => {
    it('creates a report with an id', () => {
      const report = generator.generate(reportData);
      expect(report.id).toBeTruthy();
    });

    it('sets project name and version', () => {
      const report = generator.generate(reportData);
      expect(report.projectName).toBe('TestProject');
      expect(report.version).toBe('1.0.0');
    });

    it('sets scan date', () => {
      const report = generator.generate(reportData);
      expect(report.scanDate).toEqual(scanDate);
    });

    it('computes correct summary totals', () => {
      const report = generator.generate(reportData);
      expect(report.summary.total).toBe(4);
      expect(report.summary.approved).toBe(2);
      expect(report.summary.flagged).toBe(1);
      expect(report.summary.unknown).toBe(1);
    });

    it('computes compliance score', () => {
      const report = generator.generate(reportData);
      expect(report.summary.complianceScore).toBe(50); // 2/4 * 100
    });

    it('returns 100% score for empty packages', () => {
      const report = generator.generate({ ...reportData, packages: [] });
      expect(report.summary.complianceScore).toBe(100);
    });

    it('generates package details', () => {
      const report = generator.generate(reportData);
      expect(report.details).toHaveLength(4);
      const lodash = report.details.find((d) => d.name === 'lodash');
      expect(lodash?.status).toBe('approved');
    });
  });

  describe('toJson', () => {
    it('returns valid JSON string', () => {
      const report = generator.generate(reportData);
      const json = generator.toJson(report);
      expect(() => JSON.parse(json)).not.toThrow();
    });

    it('includes project name in JSON', () => {
      const report = generator.generate(reportData);
      const json = generator.toJson(report);
      const parsed = JSON.parse(json);
      expect(parsed.projectName).toBe('TestProject');
    });
  });

  describe('toText', () => {
    it('returns a non-empty string', () => {
      const report = generator.generate(reportData);
      const text = generator.toText(report);
      expect(text.length).toBeGreaterThan(0);
    });

    it('includes project name', () => {
      const report = generator.generate(reportData);
      const text = generator.toText(report);
      expect(text).toContain('TestProject');
    });

    it('includes compliance score', () => {
      const report = generator.generate(reportData);
      const text = generator.toText(report);
      expect(text).toContain('50%');
    });

    it('includes package statuses', () => {
      const report = generator.generate(reportData);
      const text = generator.toText(report);
      expect(text).toContain('APPROVED');
      expect(text).toContain('FLAGGED');
      expect(text).toContain('UNKNOWN');
    });
  });
});
