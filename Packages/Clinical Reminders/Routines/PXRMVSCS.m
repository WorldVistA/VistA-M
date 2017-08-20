PXRMVSCS ;SLC/PKR - Value set code search routines. ;11/21/2014
 ;;2.0;CLINICAL REMINDERS;**47**;Feb 04, 2005;Build 289
 ;==========================================
CODESRCH ;Search all value sets for a specified code.
 N CODE,CSYSIEN,RESULT
 D FULL^VALM1
 S RESULT=$$GETCODE(.CSYSIEN,.CODE)
 I 'RESULT Q
 D CSEARCH(CSYSIEN,CODE)
 S VALMBCK="R"
 Q
 ;
 ;==========================================
CSEARCH(CSYSIEN,CODE) ;Find all value sets containing the specified code.
 N IND,JND,NL,TEXT,VSIEN,VSL,VSOID,VSNAME,VSVDATE
 S VSNAME=""
 F  S VSNAME=$O(^PXRM(802.2,"B",VSNAME)) Q:VSNAME=""  D
 . S VSIEN=0
 . F  S VSIEN=+$O(^PXRM(802.2,"B",VSNAME,VSIEN)) Q:VSIEN=0  D
 .. I '$D(^PXRM(802.2,VSIEN,2,"B",CSYSIEN)) Q
 .. S IND=$O(^PXRM(802.2,VSIEN,2,"B",CSYSIEN,""))
 .. S JND=0
 .. F  S JND=+$O(^PXRM(802.2,VSIEN,2,IND,1,JND)) Q:JND=0  D
 ... I ^PXRM(802.2,VSIEN,2,IND,1,JND,0)=CODE S VSL(VSNAME,VSIEN)=""
 ;Build the output.
 S TEXT(1)="Searching all value sets for the "_$P(^PXRM(802.1,CSYSIEN,0),U,1)_" code "_CODE
 I $D(VSL) S TEXT(2)="It was found in the following value sets:"
 E  S TEXT(2)=" It was not found in any value set."
 S VSNAME="",NL=2
 F  S VSNAME=$O(VSL(VSNAME)) Q:VSNAME=""  D
 . S VSIEN=0
 . F  S VSIEN=+$O(VSL(VSNAME,VSIEN)) Q:VSIEN=0  D
 .. S VSOID=$P(^PXRM(802.2,VSIEN,1),U,1)
 .. S VSVDATE=$P(^PXRM(802.2,VSIEN,1),U,3)
 .. S NL=NL+1,TEXT(NL)=""
 .. S NL=NL+1,TEXT(NL)=" "_VSNAME
 .. S NL=NL+1,TEXT(NL)=" OID: "_VSOID
 .. S NL=NL+1,TEXT(NL)=" Version date: "_$$FMTE^XLFDT(VSVDATE)
 .. S NL=NL+1,TEXT(NL)=""
 D BROWSE^DDBR("TEXT","NR","Value Set Code Search")
 Q
 ;
 ;==========================================
GETCODE(CSYSIEN,CODE) ;Prompt the user for the code to search for.
 N CSIEN,CSNAME,CSVER,DIC,DIR,X,Y
 W !!,"NLM Value Set Coding Systems"
 S CSNAME=""
 F  S CSNAME=$O(^PXRM(802.1,"B",CSNAME)) Q:CSNAME=""  D
 . S CSIEN=$O(^PXRM(802.1,"B",CSNAME,""))
 . S CSVER=$P(^PXRM(802.1,CSIEN,0),U,3)
 . W !," ",CSNAME,"  version ",CSVER
 S DIC=802.1,DIC(0)="AE"
 S DIC("A")="Select the coding system: "
 D ^DIC
 S CSYSIEN=$P(Y,U,1)
 I CSYSIEN=-1 Q 0
 S DIR(0)="FAU^3:64"
 S DIR("A")="Input the code: "
 D ^DIR
 S CODE=Y
 I CODE="^" Q 0
 Q 1
 ;
