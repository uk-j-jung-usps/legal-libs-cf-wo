import { LicenseChecker } from '../license-compliance';

export interface PackageInfo {
  name: string;
  version: string;
  license: string;
}

export interface ReportData {
  projectName: string;
  version: string;
  scanDate: Date;
  packages: PackageInfo[];
}

export interface ReportSummary {
  total: number;
  approved: number;
  flagged: number;
  unknown: number;
  complianceScore: number;
}

export interface PackageComplianceDetail {
  name: string;
  version: string;
  license: string;
  status: 'approved' | 'flagged' | 'unknown';
  notes: string;
}

export interface ComplianceReport {
  id: string;
  projectName: string;
  version: string;
  scanDate: Date;
  summary: ReportSummary;
  details: PackageComplianceDetail[];
}

function generateId(): string {
  return `${Date.now().toString(16)}-${Math.random().toString(16).slice(2)}`;
}

export class ComplianceReportGenerator {
  private checker: LicenseChecker;

  constructor() {
    this.checker = new LicenseChecker();
  }

  generate(data: ReportData): ComplianceReport {
    const details: PackageComplianceDetail[] = data.packages.map((pkg) => {
      const result = this.checker.check(pkg.name, pkg.license);
      return {
        name: pkg.name,
        version: pkg.version,
        license: pkg.license,
        status: result.status,
        notes: result.message,
      };
    });

    const approved = details.filter((d) => d.status === 'approved').length;
    const flagged = details.filter((d) => d.status === 'flagged').length;
    const unknown = details.filter((d) => d.status === 'unknown').length;
    const total = details.length;
    const complianceScore = total === 0 ? 100 : Math.round((approved / total) * 100);

    return {
      id: generateId(),
      projectName: data.projectName,
      version: data.version,
      scanDate: data.scanDate,
      summary: { total, approved, flagged, unknown, complianceScore },
      details,
    };
  }

  toJson(report: ComplianceReport): string {
    return JSON.stringify(report, null, 2);
  }

  toText(report: ComplianceReport): string {
    const lines: string[] = [
      `Compliance Report`,
      `=================`,
      `ID:           ${report.id}`,
      `Project:      ${report.projectName} v${report.version}`,
      `Scan Date:    ${report.scanDate.toISOString()}`,
      ``,
      `Summary`,
      `-------`,
      `Total:            ${report.summary.total}`,
      `Approved:         ${report.summary.approved}`,
      `Flagged:          ${report.summary.flagged}`,
      `Unknown:          ${report.summary.unknown}`,
      `Compliance Score: ${report.summary.complianceScore}%`,
      ``,
      `Package Details`,
      `---------------`,
    ];

    report.details.forEach((d) => {
      lines.push(`[${d.status.toUpperCase()}] ${d.name}@${d.version} (${d.license})`);
      lines.push(`  ${d.notes}`);
    });

    return lines.join('\n');
  }
}
