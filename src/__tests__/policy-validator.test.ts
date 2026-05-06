import { PolicyValidator, Policy } from '../policy-validator';

describe('PolicyValidator', () => {
  let validator: PolicyValidator;

  beforeEach(() => {
    validator = new PolicyValidator();
  });

  const validPolicy: Policy = {
    id: 'pol-1',
    name: 'Test Policy',
    description: 'A test policy',
    rules: [
      { id: 'rule-1', condition: 'license === "MIT"', action: 'allow', priority: 1 },
    ],
  };

  describe('validate', () => {
    it('returns valid for a correct policy', () => {
      const result = validator.validate(validPolicy);
      expect(result.valid).toBe(true);
      expect(result.errors).toHaveLength(0);
    });

    it('returns error when policy id is empty', () => {
      const policy = { ...validPolicy, id: '' };
      const result = validator.validate(policy);
      expect(result.valid).toBe(false);
      expect(result.errors).toContain('Policy id is required.');
    });

    it('returns error when policy name is empty', () => {
      const policy = { ...validPolicy, name: '' };
      const result = validator.validate(policy);
      expect(result.valid).toBe(false);
    });

    it('returns warning when description is empty', () => {
      const policy = { ...validPolicy, description: '' };
      const result = validator.validate(policy);
      expect(result.warnings).toContain('Policy description is empty.');
    });

    it('returns warning when no rules', () => {
      const policy = { ...validPolicy, rules: [] };
      const result = validator.validate(policy);
      expect(result.warnings).toContain('Policy has no rules defined.');
    });

    it('returns error for duplicate rule ids', () => {
      const policy: Policy = {
        ...validPolicy,
        rules: [
          { id: 'rule-1', condition: 'x', action: 'allow', priority: 1 },
          { id: 'rule-1', condition: 'y', action: 'deny', priority: 2 },
        ],
      };
      const result = validator.validate(policy);
      expect(result.valid).toBe(false);
      expect(result.errors.some((e) => e.includes('Duplicate'))).toBe(true);
    });

    it('returns error for missing rule condition', () => {
      const policy: Policy = {
        ...validPolicy,
        rules: [{ id: 'rule-1', condition: '', action: 'allow', priority: 1 }],
      };
      const result = validator.validate(policy);
      expect(result.valid).toBe(false);
    });

    it('includes policyId in result', () => {
      const result = validator.validate(validPolicy);
      expect(result.policyId).toBe('pol-1');
    });
  });

  describe('validateAll', () => {
    it('validates multiple policies', () => {
      const policies: Policy[] = [
        validPolicy,
        { ...validPolicy, id: 'pol-2', name: 'Policy 2' },
      ];
      const results = validator.validateAll(policies);
      expect(results).toHaveLength(2);
      results.forEach((r) => expect(r.valid).toBe(true));
    });

    it('returns empty array for empty input', () => {
      expect(validator.validateAll([])).toEqual([]);
    });
  });
});
