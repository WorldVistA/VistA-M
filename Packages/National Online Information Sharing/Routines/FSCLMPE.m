FSCLMPE ;SLC/STAFF-NOIS List Manager Protocol Edit ;5/17/98  22:26
 ;;1.1;NOIS;;Sep 06, 1998
 ;
LC ; from FSCLMP
 I '@VALMAR W !,"No calls to Edit.",! H 2 Q
 N CHOICE,DEFAULT,OK
 S CHOICE="1-"_+@VALMAR,DEFAULT=CHOICE D SELECT^FSCUL(CHOICE,"",DEFAULT,"EVALUES",.OK)
 I $O(^TMP("FSC SELECT",$J,"EVALUES",0)) D EDIT^FSCLM("EVALUES")
 S VALMBCK=$S($G(FSCEXIT):"Q",1:"R")
 Q
 ;
VC ; from FSCLMP
 N CHOICE,DEFAULT,OK,OLDFMT K OLDFMT
 S CHOICE=$G(^TMP("FSC SELECT",$J,"VVALUES")),DEFAULT=CHOICE D SELECT^FSCUL(CHOICE,"",DEFAULT,"EVALUES",.OK)
 I $O(^TMP("FSC SELECT",$J,"EVALUES",0)) M OLDFMT=FSCFMT K FSCEDIT,FSCFMT D EDIT^FSCLM("EVALUES")
 S VALMBCK=$S($G(FSCEXIT):"Q",1:"R")
 K FSCFMT M FSCFMT=OLDFMT I '$G(FSCEXIT),$G(FSCEDIT) D ENTRY^FSCLMV,HEADER^FSCLMV
 Q
 ;
EDIT ; from FSCLMP
 N DIR,X,Y K DIR
 S DIR(0)="SAMO^BASIC:BASIC;DUPLICATE:DUPLICATE;PERSONAL:PERSONAL;WORKLOAD:WORKLOAD;ALL:ALL"
 S DIR("A")="Select (B)asic, (A)ll, (W)orkload, (P)ersonal, or (D)uplicate: "
 S DIR("?",1)="Enter BASIC to edit the module, specialist, and priority."
 ;S DIR("?",2)="Enter DESCRIPTION to edit the request description."
 S DIR("?",2)="Enter ALL to edit all of the entry information on the call.  Note: The"
 S DIR("?",3)="location and date opened cannot be edited (you may cancel a call by"
 S DIR("?",4)="changing its status to cancelled)."
 S DIR("?",5)="Enter WORKLOAD to edit workload."
 S DIR("?",6)="Enter PERSONAL to edit personal fields on this call."
 S DIR("?",7)="Enter DUPLICATE to associate this call with another call."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) Q
 I Y="BASIC" D BASIC^FSCLMPE1 Q
 I Y="DESCRIPTION" D DESC^FSCLMPE1 Q
 I Y="WORKLOAD" D WKLD^FSCLMPE1 Q
 I Y="ALL" D ALL^FSCLMPE1 Q
 I Y="DUPLICATE" D PRIMARY^FSCLMPEA Q
 I Y="PERSONAL" D PFIELDS^FSCLMPE1 Q
 Q
 ;
LD ; from FSCLMP
 I '$$CHECK^FSCLMPM(FSCLNUM,DUZ) W !,"You cannot edit this list.",$C(7) H 2 Q
 I "AM"'[$P(^FSC("LIST",FSCLNUM,0),U,3) W !,"This list does not use a query definition.",$C(7) H 2 Q
 I '($D(@VALMAR)#2) S @VALMAR="" D INSERT^FSCLMPM Q
 N DIR,X,Y K DIR
 S DIR(0)="SAMO^REPLACE:REPLACE;EDIT:EDIT;INSERT:INSERT;DELETE:DELETE"
 S DIR("A")="Select (E)dit a line, (I)nsert lines, (D)elete lines, or (R)eplace all: "
 S DIR("?",1)="Enter EDIT to replace a single line in the definition."
 S DIR("?",2)="Enter INSERT to add additional lines after a selected line."
 S DIR("?",3)="Enter DELETE to delete one or more lines."
 S DIR("?",4)="Enter REPLACE to enter a new query definition."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) Q
 I Y="EDIT" D EDIT^FSCLMPM Q
 I Y="INSERT" D INSERT^FSCLMPM Q
 I Y="DELETE" D DELETE^FSCLMPM Q
 I Y="REPLACE" D  Q
 .N CHOICE,CNT,DEF,DESC,LINE,NEWDEF,NEWLINE,OK,PREOP,QDESC K DEF,DESC,NEWDEF,QDESC ; not scoped
 .D REPLACE^FSCLDR(FSCLNAME,FSCLNUM)
 Q
