RAAIPST0 ;HISC/SWM- PATCH RAD*4.5*2 Post-init Driver ;4/29/96  11:28
VERSION ;;4.5;Radiology/Nuclear Medicine;**2**;Dec 12, 1995
 ;
 Q:'+$O(^RADPT(0))  ;virgin install
 N RACHK
 S RACHK=$$NEWCP^XPDUTL("POST1","EN1^RAAIPST0")
 ;  re-create "E" nodes in ^RA(78.2,RAFMT,"E",...
 ;  only for RAFMT records that have the RAVERF variable
 Q
EN1 ; re-create file 78.2 records to change RAVERF to RAVERFDT
 N RAFMT,RA2,RA3,RATXT
 S RA3=$O(^RA(78.7,"B","VERIFIED DATE",0)) G:'RA3 16
 G:^RA(78.7,RA3,0)'["RAVERFDT" 17 G:^("E")'["RAVERFDT" 17
 S RAFMT=0
11 S RAFMT=$O(^RA(78.2,RAFMT)) G:RAFMT="" 19 S RA2=0
12 S RA2=$O(^RA(78.2,RAFMT,"E",RA2)) G:RA2="" 11
 I ^RA(78.2,RAFMT,"E",RA2,0)["RAVERF" D CMP^RAFLH1 G 11
 G 12
16 S RATXT(1)="No VERIFIED DATE record found in file #78.7" G 18
 Q
17 S RATXT(1)="No variable RAVERFDT found in the VERIFIED DATE record of file #78.7"
18 S RATXT(2)="patch post init abended." D MES^XPDUTL(.RATXT)
 Q
19 W !,*7,"PATCH post init completed."
 Q
