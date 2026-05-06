import { LegalNoticeGenerator } from '../legal-notice';

describe('LegalNoticeGenerator', () => {
  let generator: LegalNoticeGenerator;

  beforeEach(() => {
    generator = new LegalNoticeGenerator();
  });

  describe('generate', () => {
    it('includes copyright line', () => {
      const notice = generator.generate({
        companyName: 'Acme Corp',
        year: 2024,
        productName: 'MyProduct',
        licenseType: 'MIT',
      });
      expect(notice).toContain('Copyright (c) 2024 Acme Corp');
    });

    it('includes product and license info', () => {
      const notice = generator.generate({
        companyName: 'Acme Corp',
        year: 2024,
        productName: 'MyProduct',
        licenseType: 'MIT',
      });
      expect(notice).toContain('MyProduct');
      expect(notice).toContain('MIT');
    });

    it('includes additional terms when provided', () => {
      const notice = generator.generate({
        companyName: 'Acme',
        year: 2024,
        productName: 'Prod',
        licenseType: 'MIT',
        additionalTerms: ['No redistribution', 'Commercial use requires approval'],
      });
      expect(notice).toContain('No redistribution');
      expect(notice).toContain('Commercial use requires approval');
    });

    it('does not include Additional Terms section when none provided', () => {
      const notice = generator.generate({
        companyName: 'Acme',
        year: 2024,
        productName: 'Prod',
        licenseType: 'MIT',
      });
      expect(notice).not.toContain('Additional Terms');
    });
  });

  describe('generateHtml', () => {
    it('returns HTML with div wrapper', () => {
      const html = generator.generateHtml({
        companyName: 'Acme Corp',
        year: 2024,
        productName: 'MyProduct',
        licenseType: 'MIT',
      });
      expect(html).toContain('<div');
      expect(html).toContain('</div>');
    });

    it('includes copyright year and company', () => {
      const html = generator.generateHtml({
        companyName: 'Acme Corp',
        year: 2024,
        productName: 'MyProduct',
        licenseType: 'MIT',
      });
      expect(html).toContain('2024');
      expect(html).toContain('Acme Corp');
    });

    it('escapes HTML special characters', () => {
      const html = generator.generateHtml({
        companyName: 'Acme & Sons',
        year: 2024,
        productName: 'Prod<X>',
        licenseType: 'MIT',
      });
      expect(html).toContain('&amp;');
      expect(html).toContain('&lt;');
    });

    it('includes additional terms as ordered list', () => {
      const html = generator.generateHtml({
        companyName: 'Acme',
        year: 2024,
        productName: 'Prod',
        licenseType: 'MIT',
        additionalTerms: ['Term one', 'Term two'],
      });
      expect(html).toContain('<ol>');
      expect(html).toContain('<li>Term one</li>');
    });
  });
});
