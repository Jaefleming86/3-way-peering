# AWS Network Firewall - Stateless Rule Group
resource "aws_networkfirewall_rule_group" "stateless" {
  capacity = 100
  name     = "stateless-rule-group"
  type     = "STATELESS"

  rule_group {
    rules_source {
      stateless_rules_and_custom_actions {
        stateless_rule {
          rule_definition {
            actions = ["aws:pass"]
            match_attributes {
              source {
                address_definition = "10.86.0.0/16"
              }
              destination {
                address_definition = "10.70.0.0/16"
              }
              protocols = [6] 
            }
          }
          priority = 1
        }
        stateless_rule {
          rule_definition {
            actions = ["aws:pass"]
            match_attributes {
              source {
                address_definition = "10.70.0.0/16"
              }
              destination {
                address_definition = "10.86.0.0/16"
              }
              protocols = [6] 
            }
          }
          priority = 2
        }
        stateless_rule {
          rule_definition {
            actions = ["aws:pass"]
            match_attributes {
              source {
                address_definition = "10.90.0.0/16"
              }
              destination {
                address_definition = "10.86.0.0/16"
              }
              protocols = [6] 
            }
          }
          priority = 3
        }
      }
    }
  }
}

# AWS Network Firewall - Stateful Rule Group
resource "aws_networkfirewall_rule_group" "stateful" {
  capacity = 100
  name     = "stateful-rule-group"
  type     = "STATEFUL"

  rule_group {
    rules_source {
      rules_source_list {
        generated_rules_type = "ALLOWLIST"
        target_types         = ["HTTP_HOST"]
        targets              = ["allowed.host.com"]
      }
    }
  }
}

# AWS Network Firewall - Firewall Policy
resource "aws_networkfirewall_firewall_policy" "policy1" {
  name = "policy1"

  firewall_policy {
    stateless_default_actions          = ["aws:forward_to_sfe"]
    stateless_fragment_default_actions = ["aws:forward_to_sfe"]

    stateless_rule_group_reference {
      priority     = 1
      resource_arn = aws_networkfirewall_rule_group.stateless.arn
    }

    stateful_rule_group_reference {
      resource_arn = aws_networkfirewall_rule_group.stateful.arn
    }
  }
}

# AWS Network Firewall - Firewall
resource "aws_networkfirewall_firewall" "firewall1" {
  name                = "firewall1"
  firewall_policy_arn = aws_networkfirewall_firewall_policy.policy1.arn
  vpc_id              = aws_vpc.vpc1.id

  subnet_mapping {
    subnet_id = aws_subnet.public_subnet1.id
  }
}