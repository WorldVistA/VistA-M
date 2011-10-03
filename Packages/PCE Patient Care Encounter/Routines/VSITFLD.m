VSITFLD ;ISD/MRL,RJP - Visit Tracking file fields array setup ;6/20/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**76,81,111,130,124,164,168**;Aug 12, 1996;Build 14
 ; Patch PX*1*76 changes the 2nd line of all VSIT* routines to reflect
 ; the incorporation of the module into PCE.  For historical reference,
 ; the old (VISIT TRACKING) 2nd line is included below to reference VSIT
 ; patches.
 ;
 ;;2.0;VISIT TRACKING;**4**;Aug 12, 1996;
 ;
 Q
 ;
FLD ; - Visit file fields; array subscript and field DD number fmt
 ;   <visit subscript>;<field#>;<node>;<piece>;<error message>
 ;
 S ^TMP("VSITDD",$J,"VDT")="VDT;.01;0;1;Invalid Encounter/Admit Date&Time [0;1]"
 S ^TMP("VSITDD",$J,"CDT")="CDT;.02;0;2"
 S ^TMP("VSITDD",$J,"TYP")="TYP;.03;0;3;Invalid Type [0:3]"
 S ^TMP("VSITDD",$J,"PAT")="PAT;.05;0;5;Invalid Patient [0:5]"
 S ^TMP("VSITDD",$J,"INS")="INS;.06;0;6;Invalid Loc of Encounter [0:6]"
 S ^TMP("VSITDD",$J,"SVC")="SVC;.07;0;7;Invalid Service Category [0:7]"
 S ^TMP("VSITDD",$J,"DSS")="DSS;.08;0;8;Invalid DSS ID [0:8]"
 S ^TMP("VSITDD",$J,"CTR")="CTR;.09;0;9"
 S ^TMP("VSITDD",$J,"DEL")="DEL;.11;0;11"
 S ^TMP("VSITDD",$J,"LNK")="LNK;.12;0;12"
 S ^TMP("VSITDD",$J,"MDT")="MDT;.13;0;13"
 S ^TMP("VSITDD",$J,"COD")="COD;.18;0;18"
 S ^TMP("VSITDD",$J,"ELG")="ELG;.21;0;21;Invalid Eligibility [0:21]"
 S ^TMP("VSITDD",$J,"LOC")="LOC;.22;0;22;Invalid Hospital Location [0:22] - The specified Hospital Location was not found defined in the Hospital Location file."
 S ^TMP("VSITDD",$J,"USR")="USR;.23;0;23;Invalid Created by User [0:23]"
 S ^TMP("VSITDD",$J,"OPT")="OPT;.24;0;24"
 S ^TMP("VSITDD",$J,"PRO")="PRO;.25;0;25"
 S ^TMP("VSITDD",$J,"ACT")="ACT;.26;0;26"
 S ^TMP("VSITDD",$J,"OUT")="OUT;2101;21;1"
 S ^TMP("VSITDD",$J,"VID")="VID;15001;150;1"
 S ^TMP("VSITDD",$J,"IO")="IO;15002;150;2"
 S ^TMP("VSITDD",$J,"PRI")="PRI;15003;150;3"
 S ^TMP("VSITDD",$J,"SC")="SC;80001;800;1"
 S ^TMP("VSITDD",$J,"AO")="AO;80002;800;2"
 S ^TMP("VSITDD",$J,"IR")="IR;80003;800;3"
 S ^TMP("VSITDD",$J,"EC")="EC;80004;800;4"
 S ^TMP("VSITDD",$J,"MST")="MST;80005;800;5" ;added 6/17/98 for MST enhancement
 S ^TMP("VSITDD",$J,"HNC")="HNC;80006;800;6" ;PX*1*111 added for HNC enhancement
 S ^TMP("VSITDD",$J,"CV")="CV;80007;800;7" ;PX*1*130 Combat Veteran
 S ^TMP("VSITDD",$J,"SHAD")="SHAD;80008;800;8" ;PX*1*168 Project 112/SHAD
 S ^TMP("VSITDD",$J,"SCEF")="SCED;80011;800;11" ;PX*1*124 SC EDIT FLAG
 S ^TMP("VSITDD",$J,"AOEF")="AOED;80012;800;12" ;PX*1*124 AO EDIT FLAG
 S ^TMP("VSITDD",$J,"IREF")="IRED;80013;800;13" ;PX*1*124 IR EDIT FLAG
 S ^TMP("VSITDD",$J,"ECEF")="ECED;80014;800;14" ;PX*1*124 EC EDIT FLAG
 S ^TMP("VSITDD",$J,"MSTEF")="MSTED;80015;800;15" ;PX*1*124 MST EDIT FLAG
 S ^TMP("VSITDD",$J,"HNCEF")="HNCED;80016;800;16" ;PX*1*124 HNC EDIT FLAG
 S ^TMP("VSITDD",$J,"CVEF")="CVED;80017;800;17" ;PX*1*124 CV EDIT FLAG
 S ^TMP("VSITDD",$J,"SHADEF")="SHADED;80018;800;18" ;PX*1*168 SHAD EDIT FLAG
 S ^TMP("VSITDD",$J,"COM")="COM;81101;811;1"
 S ^TMP("VSITDD",$J,"VER")="VER;81201;812;1"
 S ^TMP("VSITDD",$J,"PKG")="PKG;81202;812;2"
 S ^TMP("VSITDD",$J,"SOR")="SOR;81203;812;3"
 Q
 ;
