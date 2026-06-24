export interface NoticeConfig {
  companyName: string;
  year: number;
  productName: string;
  licenseType: string;
  additionalTerms?: string[];
}

export class LegalNoticeGenerator {
  generate(config: NoticeConfig): string {
    const lines: string[] = [
      `Copyright (c) ${config.year} ${config.companyName}`,
      ``,
      `${config.productName} is licensed under the ${config.licenseType} license.`,
      ``,
      `All rights reserved.`,
    ];
    if (config.additionalTerms && config.additionalTerms.length > 0) {
      lines.push('');
      lines.push('Additional Terms:');
      config.additionalTerms.forEach((term, i) => {
        lines.push(`${i + 1}. ${term}`);
      });
    }
    return lines.join('\n');
  }

  generateHtml(config: NoticeConfig): string {
    const escape = (s: string) =>
      s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');

    let html = `<div class="legal-notice">`;
    html += `<p><strong>Copyright &copy; ${config.year} ${escape(config.companyName)}</strong></p>`;
    html += `<p>${escape(config.productName)} is licensed under the ${escape(config.licenseType)} license.</p>`;
    html += `<p>All rights reserved.</p>`;

    if (config.additionalTerms && config.additionalTerms.length > 0) {
      html += `<p><strong>Additional Terms:</strong></p><ol>`;
      config.additionalTerms.forEach((term) => {
        html += `<li>${escape(term)}</li>`;
      });
      html += `</ol>`;
    }

    html += `</div>`;
    return html;
  }
}
