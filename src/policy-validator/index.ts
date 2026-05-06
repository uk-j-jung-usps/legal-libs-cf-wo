export interface PolicyRule {
  id: string;
  condition: string;
  action: 'allow' | 'deny' | 'warn';
  priority: number;
}

export interface Policy {
  id: string;
  name: string;
  description: string;
  rules: PolicyRule[];
}

export interface ValidationResult {
  policyId: string;
  valid: boolean;
  errors: string[];
  warnings: string[];
}

export class PolicyValidator {
  validate(policy: Policy): ValidationResult {
    const errors: string[] = [];
    const warnings: string[] = [];

    if (!policy.id || policy.id.trim() === '') {
      errors.push('Policy id is required.');
    }
    if (!policy.name || policy.name.trim() === '') {
      errors.push('Policy name is required.');
    }
    if (!policy.description || policy.description.trim() === '') {
      warnings.push('Policy description is empty.');
    }
    if (!policy.rules || policy.rules.length === 0) {
      warnings.push('Policy has no rules defined.');
    } else {
      const ruleIds = new Set<string>();
      policy.rules.forEach((rule, index) => {
        if (!rule.id || rule.id.trim() === '') {
          errors.push(`Rule at index ${index} is missing an id.`);
        } else if (ruleIds.has(rule.id)) {
          errors.push(`Duplicate rule id: ${rule.id}.`);
        } else {
          ruleIds.add(rule.id);
        }
        if (!rule.condition || rule.condition.trim() === '') {
          errors.push(`Rule ${rule.id || index} is missing a condition.`);
        }
        if (!['allow', 'deny', 'warn'].includes(rule.action)) {
          errors.push(`Rule ${rule.id || index} has an invalid action: ${rule.action}.`);
        }
        if (typeof rule.priority !== 'number') {
          errors.push(`Rule ${rule.id || index} has an invalid priority.`);
        }
      });
    }

    return {
      policyId: policy.id,
      valid: errors.length === 0,
      errors,
      warnings,
    };
  }

  validateAll(policies: Policy[]): ValidationResult[] {
    return policies.map((p) => this.validate(p));
  }
}
