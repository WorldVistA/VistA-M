PSSMIGR1 ;AJF - Receives and Process XML message from PEPS; 10/31/2011 1845
 ;;1.0;PHARMACY ENTERPRISE PRODUCT SYSTEM;;;Build 35
 ;;
 ; Called from PSSMIGR - calls to PSSMIGR2
 ; Process migration request
 ;;
EN(FL,IEN,RCNT,TYPE) ;Entry point into routine
 ;  FL   - File Number
 ;  IEN  - The starting IEN
 ;  RCNT - Number of records desired
 ;  TYPE - 1 or 2
 ;
 ;Global Variables:
 ;  FNAME,FNAME1,FNUM
 ;
 S FNAME="drugMigrationResponse.XML"
 I FL=""!(IEN="")!(RCNT="")!(TYPE="") D OUT^PSSMIGR(" Error... Missing required data") Q
 N XST,CNT
 S CNT=0,XST=0
 S:IEN'=0 IEN=IEN-1
 I FL=50.607 D DUNI Q  ;Drug Unit
 I FL=50.416 D DING Q  ;Drug Ingredients
 I FL=50.6 D VAGN Q  ;VA Generic Name
 I FL=50.64 D VADU Q  ;VA Dispense Unit
 I FL=50.605 D VADC Q  ;VA Drug Class
 I FL=50.606 D DSFO^PSSMIGR2(IEN,RCNT,TYPE) Q  ;Dosage Form
 I FL=50.68 D VAPD^PSSMIGR2(IEN,RCNT,TYPE) Q  ;VA Product
 ;
 ;File Error Process
 D OUT^PSSMIGR(" Error... Invalid File Number")
 Q
 ;
DUNI ; Process Migration for DRUG UNIT file
 ;
 N IND,NAME,PS0,XIEN,XTYPE,XIND
 K ^TMP($J,50.607)
 S CNT=0,^TMP($J,50.607,"EOF")=0
 S FNAME="drugMigrationResponse_DrugUnits.XML",FNUM=50.607
 S FNAME1="drugUnits"
 I IEN<0 D OUT^PSSMIGR(" Error... Invalid IEN") Q
 I RCNT<1 D OUT^PSSMIGR(" Error... Invalid Number of Elements") Q
 I TYPE>1!(TYPE<0) D OUT^PSSMIGR(" Error... Invalid TYPE") Q
 F  S IEN=$O(^PS(50.607,IEN)) D  Q:XST=1
 .I IEN="B" S ^TMP($J,50.607,"EOF")=1,XST=1 Q
 .I RCNT=CNT S XST=1 Q
 .S PS0=^PS(50.607,IEN,0)
 .S NAME=$P(PS0,"^"),IND=$P(PS0,"^",2)
 .S XTYPE=$S(+IND:0,1:1)
 .S:+IND IND=$$FMTHL7^XLFDT(IND)
 .S XIEN="<drugUnitsIen>"_IEN_"</drugUnitsIen>"
 .S XNAME=$S(NAME="":"",1:"<name>"_NAME_"</name>")
 .S XIND=$S(IND="":"",1:"<inactivationDate>"_IND_"</inactivationDate>")
 .S ^TMP($J,50.607,XTYPE,IEN)=XIEN_XNAME_XIND
 .S:XTYPE=TYPE CNT=CNT+1
 Q
 ;
VADU ; Process Migration for VA Dispense UNIT file
 ;
 N CNT,IND,NAME,PS0,XIEN,XTYPE,XIND
 K ^TMP($J,50.64)
 S CNT=0,^TMP($J,50.64,"EOF")=0
 S FNAME="drugMigrationResponse_vaDispenseUnits.XML",FNUM=50.64
 S FNAME1="vaDispenseUnit"
 I IEN<0 D OUT^PSSMIGR(" Error... Invalid IEN") Q
 I RCNT<1 D OUT^PSSMIGR(" Error... Invalid Starting Record Number") Q
 I TYPE>1!(TYPE<0) D OUT^PSSMIGR(" Error... Invalid TYPE") Q
 F  S IEN=$O(^PSNDF(50.64,IEN)) D  Q:XST=1
 .I IEN="B" S ^TMP($J,50.64,"EOF")=1,XST=1 Q
 .I RCNT=CNT S XST=1 Q
 .S PS0=^PSNDF(50.64,IEN,0)
 .S NAME=$P(PS0,"^"),IND=$P(PS0,"^",2)
 .S XTYPE=$S(+IND:0,1:1)
 .S:+IND IND=$$FMTHL7^XLFDT(IND)
 .S XIEN="<dispenseUnitsIen>"_IEN_"</dispenseUnitsIen>"
 .S XNAME=$S(NAME="":"",1:"<name>"_NAME_"</name>")
 .S XIND=$S(IND="":"",1:"<inactivationDate>"_IND_"</inactivationDate>")
 .S ^TMP($J,50.64,XTYPE,IEN)=XIEN_XNAME_XIND
 .S:XTYPE=TYPE CNT=CNT+1
 Q
 ;
DING ; Process Migration for Drug Ingredients file
 ;
 N CNT,IND,MAEN,MIEN,NAME,PRIN,PS0,PST0,PSV,STA,VUID,XEDT,XIEN,XPRIN,XSTA,XTYPE,XIND,XMAEN,XVUID
 K ^TMP($J,50.416)
 S CNT=0,^TMP($J,50.416,"EOF")=0
 S FNAME="drugMigrationResponse_DrugIngredients.XML",FNUM=50.416
 S FNAME1="drugIngredients"
 I IEN<0 D OUT^PSSMIGR(" Error... Invalid IEN") Q
 I RCNT<1 D OUT^PSSMIGR(" Error... Invalid Starting Record Number") Q
 I TYPE>1!(TYPE<0) D OUT^PSSMIGR(" Error... Invalid TYPE") Q
 F  S IEN=$O(^PS(50.416,IEN)) D  Q:XST=1
 .I +IEN=0 S ^TMP($J,50.416,"EOF")=1,XST=1 Q
 .I RCNT=CNT S XST=1 Q
 .S PS0=^PS(50.416,IEN,0)
 .S NAME=$P(PS0,"^"),PRIN=$P(PS0,"^",2),IND=$P($G(^PS(50.416,IEN,2)),"^")
 .S:+PRIN PRIN=$P($G(^PS(50.416,PRIN,0)),"^")
 .S XTYPE=$S(+IND:0,1:1)
 .S:+IND IND=$$FMTHL7^XLFDT(IND)
 .S PSV=$G(^PS(50.416,IEN,"VUID"))
 .S MAEN=$P(PSV,"^",2),VUID=$P(PSV,"^")
 .S XIEN="<drugIngredientsIen>"_IEN_"</drugIngredientsIen>"
 .S XNAME=$S(NAME="":"",1:"<name><![CDATA["_NAME_"]]></name>")
 .S XPRIN=$S(PRIN="":"",1:"<primaryIngredient><![CDATA["_PRIN_"]]></primaryIngredient>")
 .S XIND=$S(IND="":"",1:"<inactivationDate>"_IND_"</inactivationDate>")
 .S XMAEN="<masterEntryForVuid>"_MAEN_"</masterEntryForVuid>"
 .S XVUID="<vuid>"_VUID_"</vuid>"
 .S ^TMP($J,50.416,XTYPE,IEN)=XIEN_XNAME_XPRIN_XIND_XMAEN_XVUID
 .I $D(^PS(50.416,IEN,"TERMSTATUS",0)) D
 ..S MIEN=0
 ..F  S MIEN=$O(^PS(50.416,IEN,"TERMSTATUS",MIEN)) Q:MIEN="B"  D
 ...S PST0=^PS(50.416,IEN,"TERMSTATUS",MIEN,0)
 ...S EDT=$P(PST0,"^"),STA=$P(PST0,"^",2)
 ...S EDT=$$FMTHL7^XLFDT(EDT)
 ...S XEDT="<effectiveDateTime>"_EDT_"</effectiveDateTime>"
 ...S XSTA="<status>"_STA_"</status>"
 ...S ^TMP($J,50.416,XTYPE,IEN,MIEN)="<effectiveDateTime>"_XEDT_XSTA_"</effectiveDateTime>"
 .S:XTYPE=TYPE CNT=CNT+1
 Q
 ;
VAGN ; Process Migration for VA Generic Name
 ;
 N CNT,XST,PSV,XVUID,MAEN,XMAEN,XIND,XNAME,IND,MIEN,NAME,PS0,PST0,STA,VUID,XEDT,XIEN,XSTA,XTYPE
 K ^TMP($J,50.6)
 S CNT=0,^TMP($J,50.6,"EOF")=0,XST=0
 S FNAME="drugMigrationResponse_VAGeneric.XML",FNUM=50.6
 S FNAME1="vaGenericName"
 I IEN<0 D OUT^PSSMIGR(" Error... Invalid IEN") Q
 I RCNT<1 D OUT^PSSMIGR(" Error... Invalid Starting Record Number") Q
 I TYPE>1!(TYPE<0) D OUT^PSSMIGR(" Error... Invalid TYPE") Q
 F  S IEN=$O(^PSNDF(50.6,IEN)) D  Q:XST=1
 .I +IEN=0 S ^TMP($J,50.6,"EOF")=1,XST=1 Q
 .I RCNT=CNT S XST=1 Q
 .S PS0=^PSNDF(50.6,IEN,0)
 .S NAME=$P(PS0,"^"),IND=$P(PS0,"^",2)
 .S XTYPE=$S(+IND:0,1:1)
 .S:+IND IND=$$FMTHL7^XLFDT(IND)
 .S PSV=$G(^PSNDF(50.6,IEN,"VUID"))
 .S MAEN=$P(PSV,"^",2),VUID=$P(PSV,"^")
 .S XIEN="<vaGenericIen>"_IEN_"</vaGenericIen>"
 .S XNAME=$S(NAME="":"",1:"<name><![CDATA["_NAME_"]]></name>")
 .S XIND=$S(IND="":"",1:"<inactivationDate>"_IND_"</inactivationDate>")
 .S XMAEN="<masterEntryForVuid>"_MAEN_"</masterEntryForVuid>"
 .S XVUID="<vuid>"_VUID_"</vuid>"
 .S ^TMP($J,50.6,XTYPE,IEN)=XIEN_XNAME_XIND_XMAEN_XVUID
 .I $D(^PSNDF(50.6,IEN,"TERMSTATUS",0)) D
 ..S MIEN=0
 ..F  S MIEN=$O(^PSNDF(50.6,IEN,"TERMSTATUS",MIEN)) Q:MIEN="B"  D
 ...S PST0=^PSNDF(50.6,IEN,"TERMSTATUS",MIEN,0)
 ...S EDT=$P(PST0,"^"),STA=$P(PST0,"^",2)
 ...S EDT=$$FMTHL7^XLFDT(EDT)
 ...S XEDT="<effectiveDateTime>"_EDT_"</effectiveDateTime>"
 ...S XSTA="<status>"_STA_"</status>"
 ...S ^TMP($J,50.6,XTYPE,IEN,MIEN)="<effectiveDateTime>"_XEDT_XSTA_"</effectiveDateTime>"
 .S:XTYPE=TYPE CNT=CNT+1
 Q
VADC ; Process Migration for VA DRUG CLASS
 ;
 N CNT,CODE,CODE1,CLASS,CLASS1,EDT,MAEN,MIEN,PCLS,PS0,PS01,PS10,PST0,PSV,STA,TYP,VUID
 N XCLASS,XCLASS1,XCODE,XCODE1,XEDT,XIEN,XIEN1,XMIEN,XPCLS,XSTA,XTMP,XTYP,XMAEN,XVUID
 K ^TMP($J,50.605)
 S CNT=0,^TMP($J,50.605,"EOF")=0
 S FNAME="drugMigrationResponse_DrugClass.XML",FNUM=50.605
 S FNAME1="vaDrugClass"
 I IEN<0 D OUT^PSSMIGR(" Error... Invalid IEN") Q
 I RCNT<1 D OUT^PSSMIGR(" Error... Invalid Starting Record Number") Q
 I TYPE>3!(TYPE<0) D OUT^PSSMIGR(" Error... Invalid TYPE") Q
 F  S IEN=$O(^PS(50.605,IEN)) D  Q:XST=1
 .I +IEN=0 S ^TMP($J,50.605,"EOF")=1,XST=1 Q
 .I RCNT=CNT S XST=1 Q
 .S PS0=^PS(50.605,IEN,0)
 .S CODE=$P(PS0,"^"),CLASS=$P(PS0,"^",2),PCLS=$P(PS0,"^",3),TYP=$P(PS0,"^",4)
 .I TYP="" S TYP=3
 .Q:TYP'=TYPE
 .S PSV=$G(^PS(50.605,IEN,"VUID"))
 .S MAEN=$P(PSV,"^",2),VUID=$P(PSV,"^"),XTMP=""
 .;
 .;Drug class row
 .I +PCLS,$D(^PS(50.605,PCLS,0)) D
 ..S PS01=^PS(50.605,PCLS,0)
 ..S CODE1=$P(PS01,"^"),CLASS1=$P(PS01,"^",2)
 ..S XIEN1="<vaDrugClassIen>"_PCLS_"</vaDrugClassIen>"
 ..S XCODE1=$S(CODE1="":"",1:"<code>"_CODE1_"</code>")
 ..S XCLASS1=$S(CLASS1="":"",1:"<classification>"_CLASS1_"</classification>")
 ..S XTMP=XIEN1_XCODE1_XCLASS1
 .;
 .S XIEN="<vaDrugClassIen>"_IEN_"</vaDrugClassIen>"
 .S XCODE=$S(CODE="":"",1:"<code>"_CODE_"</code>")
 .S XCLASS=$S(CLASS="":"",1:"<classification>"_CLASS_"</classification>")
 .S XPCLS=$S(PCLS="":"",1:"<parentClass>"_XTMP_"</parentClass>")
 .S XTYP=$S(TYP="":"",1:"<type>"_TYP_"</type>")
 .S XMAEN="<masterEntryForVuid>"_MAEN_"</masterEntryForVuid>"
 .S XVUID="<vuid>"_VUID_"</vuid>"
 .S ^TMP($J,50.605,TYP,IEN)=XIEN_XCODE_XCLASS_XPCLS_XTYP_XMAEN_XVUID
 .;
 .;Effective Date/Time Multiple
 .I $D(^PS(50.605,IEN,"TERMSTATUS",0)) D
 ..S MIEN=0
 ..F  S MIEN=$O(^PS(50.605,IEN,"TERMSTATUS",MIEN)) Q:MIEN="B"  D
 ...S PST0=^PS(50.605,IEN,"TERMSTATUS",MIEN,0)
 ...S EDT=$P(PST0,"^"),STA=$P(PST0,"^",2)
 ...S EDT=$$FMTHL7^XLFDT(EDT)
 ...S XEDT="<effectiveDateTime>"_EDT_"</effectiveDateTime>"
 ...S XSTA="<status>"_STA_"</status>"
 ...S ^TMP($J,50.605,TYP,IEN,MIEN)="<effectiveDateTime>"_XEDT_XSTA_"</effectiveDateTime>"
 .; Description - Word Processing Multiple
 .I $D(^PS(50.605,IEN,1,0)) D
 ..S MIEN=0
 ..F  S MIEN=$O(^PS(50.605,IEN,1,MIEN)) Q:MIEN=""  D
 ...S PS10=^PS(50.605,IEN,1,MIEN,0)
 ...S XMIEN="4"_MIEN
 ...S ^TMP($J,50.605,TYP,IEN,XMIEN)="<description>"_PS10_"</description>"
 .S:TYP=TYPE CNT=CNT+1
 Q
