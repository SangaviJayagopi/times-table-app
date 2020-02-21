import matlab.unittest.TestRunner;
import matlab.unittest.Verbosity;
import matlab.unittest.plugins.CodeCoveragePlugin;
import matlab.unittest.plugins.XMLPlugin;
import matlab.unittest.plugins.codecoverage.CoverageReport;
import matlab.unittest.plugins.codecoverage.CoberturaFormat;

suite = testsuite(pwd, 'IncludeSubfolders', true);

[~,~] = mkdir('code-coverage');
[~,~] = mkdir('test-results');

runner = TestRunner.withTextOutput('OutputDetail', Verbosity.Detailed);
runner.addPlugin(XMLPlugin.producingJUnitFormat('test-results/results.xml'));
runner.addPlugin(CodeCoveragePlugin.forFolder({'.'}, 'IncludingSubfolders', true, 'Producing', CoverageReport('code-coverage')));
runner.addPlugin(CodeCoveragePlugin.forFolder({'.'}, 'IncludingSubfolders', true, 'Producing', CoberturaFormat('code-coverage/coverage.xml')));

results = runner.run(suite);

nfailed = nnz([results.Failed]);
assert(nfailed == 0, [num2str(nfailed) ' tests failed.']);
