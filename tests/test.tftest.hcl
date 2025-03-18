mock_provider "aws" {}

# Tests
run "valid_required_vars" {
  command = plan
  variables {
    domain_identities = [{domain = "dnxlabs.com"}]
  }
}

run "should_fail_if_invalid_matching_type_on_event_destinations" {
  command = plan
  variables {
    domain_identities = [{domain = "dnxlabs.com"}]
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
    domain_identities = [{domain = "dnxlabs.com"}]
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
    domain_identities = [{domain = "dnxlabs.com"}]
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

