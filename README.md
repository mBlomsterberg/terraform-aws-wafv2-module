
<br />
<div id="readme-top" align="center">
  <a href="https://github.com/mBlomsterberg/">
    <picture>
      <source srcset="logo_inv.png" media="(prefers-color-scheme: dark)">
      <img src="logo.png" width="200" height="200">
    </picture>
  </a>

  <h3 align="center">terraform-aws-wafv2-module</h3>

  <p align="center">
    Terraform Module for AWS WAFv2 creation.
    <br />
    <br />
    <a href="https://github.com/mBlomsterberg/hanayama-repository-standard">Github Workflows</a>
    ·
    <a href="https://github.com/mBlomsterberg/hanayama-repository-standard">Repository Configuration</a>
    ·
    <a href="https://github.com/mBlomsterberg/hanayama-repository-standard">Versioning</a>
  </p>
  <br />
</div>

<div align="center">
<img src="https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white"><img src="https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white">
</div>
<br>

# About
This Terraform module creates an AWS WAFv2 WebACL with associated rules and conditions. 

## Limitations
1. Regional vs Global rules: This module only supports `regional` rules for now.
2. Recursive rules are not supported by this module(`and_statement`, `not_statement` and `or_statement`).
3. Statements not yet implemented: 
    * `label_match_statement`
    * `regex_match_statement`
    * `size_constraint_statement`
    * `sqli_match_statement`
    * `xss_match_statement`
    * `managed_rule_group_statement`
    * `rule_group_reference_statement`


# Contact 
**Github** [mBlomsterberg](https://github.com/mBlomsterberg) 

# Repository overview
| `File`                        | `description` |
| ------------------            | ------------- |
| .github/ISSUE_TEMPLATE        | Configuring issue templates for your repository |
| .github/pull_request_template.yml | Configuring default PR template for your repository    |
| .github/dependabot.yml        | Customize how Dependabot maintains your repositories  |
| CODE_OF_CONDUCT.md            | Defines standards for how to engage in a community    | 
| CONTRIBUTING.md               | Contribution guidelines to your project's repository  |
| SECURITY.md                   | To give people instructions on how to report security vulnerabilities | 
| SUPPORT.md                    | Let people know about ways to get help with your project  |
| CODEOWNERS                    | Define individuals or teams that are responsible for code in a repository |
| LICENSE                       | A software license tells others what they can and can't do with your source code  |


# Contribution guidelines
Should your repository be open to an external or onboarding new members you can create guidelines to communicate how people should contribute to your project. [Example](https://github.com/github/docs/blob/main/CONTRIBUTING.md).

# Code of Conduct

This project has adopted the Hanayama Co. Code of Conduct. For more information see the Code of Conduct FAQ or contact [mBlomsterberg](https://github.com/mBlomsterberg) with any additional questions or comments.

# License

Copyright (c) mBlomsterberg All rights reserved.

Licensed under the MIT license.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
