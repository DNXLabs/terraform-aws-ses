mock_provider "aws" {}

variables {
  environment_name       = "development"
  owner_name             = "AUSIEX"
  secrets_manager_cmk_id = ""
}

# Tests
run "valid_required_vars" {
  command = plan
  variables {
    domain = "dnxlabs.com"
  }
}

run "should_fail_if_invalid_matching_type_on_event_destinations" {
  command = plan
  variables {
    domain = "dnxlabs.com"
    configuration_sets = [{
      name            = "test_configuration_set"
      redirect_domain = "test.dnxlabs.com"
    }]
    event_destinations = [{
      name                   = "test_destination"
      configuration_set_name = "test_configuration_set"
      enabled                = true
      matching_types         = ["invalid_type"]
    }]
  }
  expect_failures = [var.event_destinations]
}


run "should_fail_if_invalid_configuration_set_name_on_event_destinations" {
  command = plan
  variables {
    domain = "dnxlabs.com"
    configuration_sets = [{
      name            = "test_configuration_set"
      redirect_domain = "test.dnxlabs.com"
    }]
    event_destinations = [{
      name                   = "test_destination"
      configuration_set_name = "invalid_test_configuration_set"
      enabled                = true
      matching_types         = ["send"]
    }]
  }
  expect_failures = [var.event_destinations]
}

run "should_succeed_if_all_valid_vars" {
  command = plan
  variables {
    domain = "dnxlabs.com"
    configuration_sets = [{
      name            = "test_configuration_set"
      redirect_domain = "test.dnxlabs.com"
    }]
    event_destinations = [{
      name                   = "test_destination"
      configuration_set_name = "test_configuration_set"
      enabled                = true
      matching_types         = ["send"]
    }]
  }
}


# run "valid_all_vars" {
#   command = plan
#   variables {
#     plan_name                     = "daily"
#     source_vault_name             = "main-development-apse2-bv"
#     source_vault_retention_period = "7"
#     replica_rules = [
#       {
#         rule_name                        = "test-rule"
#         schedule                         = "*"
#         replica_vault_arn                = "arn:aws:backup:ap-southeast-2:451292820438:backup-vault:main.replica-development-apse2-bv"
#         replica_vault_retention_period   = 90
#         replica_vault_cold_storage_after = 1
#         enable_continuous_backup         = true
#         lifecycle = {
#           cold_storage_after = 7
#           delete_after       = 35
#         }
#       }
#     ]
#   }
# }
