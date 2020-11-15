# Helm Chart Unit Testing Example

The repository demonstrates how to use the Ruby [MiniTest] test framework to unit test Helm Charts.

All the boilerplate code with convenience helpers and wrapper is located in `test/test_helper.rb`. 
`test/charts/web_spec.rb` contains the example unit tests for the Helm Chart `chart/web`.

We use [helm template] and [jq] to run the test, so must make sure you have Helm installed and the JQ development
libraries are installed on your workstation.

A couple more details are explain in my blog post [Helm Chart Unit Testing]

[MiniTest]: https://github.com/seattlerb/minitest/
[helm template]: https://helm.sh/docs/helm/helm_template/
[jq]: https://stedolan.github.io/jq/
[Helm Chart Unit Testing]: https://hodari.be/posts/2020_11_15_helm_charts_unit_testing/
