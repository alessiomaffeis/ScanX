ScanX
=====

ScanX is the core component of the iOScanX project. It is a Cocoa Framework which offers a set of objects and abstractions that can be used within Cocoa Applications to implement scanning workflows.

The ScanX framework revolves around a handful of simple and clear concepts: the main one is the SXScanner object, which is responsible for coordinating all the operations in the workflow, from scanning to evaluation. Then, there is the SX- Module object, which is used to encapsulate an individual analysis task. During the scanning phase, SXModule objects produce numeric results with respect to a number of SXMetric(s) defined by the developer. Last but not least, the SXEvaluation object, is used to represent evaluation functions in the form of parametric algebraic expressions, relying on SXMetric(s) for the variables. The SXEvaluation object has the ability to evaluate its own expression against all the items, given that a comprehensive dictionary of SXMetrics values is supplied for the substitution, for each and every item.

Noticeably, there is not a dedicated object for the item, as ScanX does not impose any constraint on the data type of the items that are subjected to analysis.

The SXScanner object transparently manages the collections of items, modules, evaluations and results. Applications based on the ScanX framework can use SXScanner’s instance methods to get them into the loop, start/stop scanning and evaluation, and fetch the results.
