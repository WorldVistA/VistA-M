ORLP3AUT ; slc/CLA -  Automatically load patients into team lists ;7/21/96
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9**;Dec 17, 1997
 Q
EN ;called by protocol ORU AUTOLIST - automatically update lists with AUTOLINK set.
 Q:'$D(DGPMT)!('$D(DFN))
 I $L($T(EN^ORLPAUT0))>0 D EN^ORLPAUT0
 Q
