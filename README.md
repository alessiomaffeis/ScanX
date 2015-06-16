ScanX
=====

Automation is not an easy goal to achieve in application assessment. In fact, automating analysis is such a complex task that most of the existing efforts have been more focused on giving some sort of assistance to the operator of the assessment (the security researcher) rather than achieving full-blown automation. Thinking of traditional, well-known assessment techniques, it is important to note that just a small subset of them are suitable for complete automation with no need of reworking.

But while most of the common tasks are either not automatable at all or are just partially so, there are many cases in which full-blown automation is highly desirable, notably when there is a need of performing very specific, targeted tests on a massive number of subjects.

ScanX, which stands for “Scanner for OS X”, is an endeavour to address the broad range of situations sharing this common denominator. ScanX is not just another tool, it is instead a simple yet solid framework that aims at providing a common starting point in the process of automating static analysis and evaluation tasks on OS X.

![alt tag](http://i.imgur.com/0vEOyar.png)

ScanX is the core component of the iOScanX project. Technically speaking, it is a Cocoa Framework, a bundle (a structured directory) that contains a dynamic shared library along with optional associated resources, such as nib files, image files, and header files.

As a framework, ScanX’s code cannot be executed directly by any means. What it does actually offer is a set of objects and abstractions that can be used within Cocoa Applications to implement scanning workflows.

The ScanX framework revolves around a handful of simple and clear concepts: the main one is the SXScanner object, which is responsible for coordinating all the operations in the workflow, from scanning to evaluation. Then, there is the SXModule object, which is used to encapsulate an individual analysis task. During the scanning phase, SXModule objects produce numeric results with respect to a number of SXMetric(s) defined by the developer. Last but not least, the SXEvaluation object, is used to represent evaluation functions in the form of parametric algebraic expressions, relying on SXMetric(s) for the variables. The SXEvaluation object has the ability to evaluate its own expression against all the items, given that a comprehensive dictionary of SXMetrics values is supplied for the substitution, for each and every item.

Noticeably, there is not a dedicated object for the item, as ScanX does not impose any constraint on the data type of the items that are subjected to analysis.

The SXScanner object transparently manages the collections of items, modules, evaluations and results. Applications based on the ScanX framework can use SXScanner’s instance methods to get them into the loop, start/stop scanning and evaluation, and fetch the results. SXScanner makes use of the delegation design pattern to communicate with its controller object, sending messages to inform it about the status of the analysis, at the appropriate time.

![alt tag](http://i.imgur.com/BGcfySn.png)
