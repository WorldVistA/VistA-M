%utt2 ; VEN/SMH - Bad Ass Continuation of Unit Tests;02/06/17  13:48
 ;;1.5;MASH UTILITIES;;Jul 8, 2017;Build 13
 ; Submitted to OSEHRA Jul 8, 2017 by Joel L. Ivey under the Apache 2 license (http://www.apache.org/licenses/LICENSE-2.0.html)
 ; Original routine authored by Sam H. Habiel
 ; Modifications made by Joel L. Ivey 05/2014-09/2015
 ;
%ut ;  List of changes in routine %ut in version 1.5
 ; 160713 JLI in ERROR1 moved actual BREAK on error, if BREAK option is specified from first executable line so actual error is listed before BREAK occurs
 ; 161020 JLI when BREAKing due to use of BREAK option, added code to indicate breaking on a false or nonequal value, or if breaking on an error the type of error causing the break
 ; 161113 JLI in EN1 added code to insert routine names before list of tags executed in verbose mode
 ; 161204 SMH added verbosity options for executions timing for tests to verbose output vaue 2 gives milliseconds or 3 gives microseconds expressed as fractional milliseconds
 ; 161204 SMH added tags GTMVER and ZHDIF related to execution timing
 ; 161206 JLI added tag GETSYS to handle cases where in Cache Windows systems with a computer name beginning with a digit are not correctly identified - originally reported by Steve Graham
 ; 161206 JLI changed all references to +$SY to calls to $$GETSYS in this routine
 ; 170111 JLI added code to work with SMH changes to %ut1 to permit single or multiple namespaces be passed for coverage analysis
 ;
%ut1 ; List of changes made in routine %ut1 in version 1.5
 ; 160316 JLI Modified checks that prevented some routines from being included in tests (e.g., name on line 1 doesn't match) or excluding, but notifying user if a routine looks like computer generated (no ;; 2nd line)
 ; 160701 Christopher Edwards (CE) suggested removing VistA dependence in CACHECOV+12 replaced ^%ZOSF("LOAD") with its code
 ; 161020 JLI on FAIL if BREAK was active added message indicating breaking on failure before actual BREAK
 ; 161206 JLI changed all references to +$SY to calls to $$GETSYS in %ut
 ; 161226 SMH added code to permit single or multiple namespaces be passed for coverage analysis
 ;
T11 ; @TEST An @TEST Entry point in Another Routine invoked through XTROU offsets
 D CHKTF^%ut(1)
 QUIT
T12 ;
 D CHKTF^%ut(1)
 QUIT
XTENT ;
 ;;T12;An XTENT offset entry point in Another Routine invoked through XTROU offsets
