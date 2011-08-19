ESP122PT ;ALB/JAP; POST-INSTALL FOR ES*1*22;3/98
 ;;1.0;POLICE & SECURITY;**22**;Mar 31, 1994
EN ;entry point
 ;no harm is done if run multiple times
 N ZTSK,ZTRTN,ZTDESC,ZTREQ,ZTSAVE,ZTIO,ZTDTH,ESPC,ESPU
 D FILE1
 D FILE2
 D CONVERT
 ;print conversion reports
 S ESPION=$G(XPDQUES("POSPRINT","B"))
 I ESPION=""!(ESPION["^") K ESPION
 I $D(ESPION) S ZTIO=ESPION
 S (ESPC,ESPU)=1 D NOW^%DTC S %=$E(%,1,12),ZTDTH=%+.001
 S ZTRTN="PRINT^ESP122P1",ZTDESC="Print ES*1*22 Conversion Report",ZTREQ="@"
 S ZTSAVE("ESPC")="",ZTSAVE("ESPU")="",ZTSAVE("ZTREQ")=""
 D ^%ZTLOAD
 I $G(ZTSK)>0 D
 .W !!,"Conversion Reports queued as Task #",ZTSK,".",!!
 I '$G(ZTSK) D
 .W !!,"Unable to queue Conversion Reports.",!,"Use the Conversion Management print option later.",!!
 K ESPION
 Q
 ;
FILE1 ;add new entries to file #912.9
 N I,J,TEXT,TYPE,CAT,DIC,DLAYGO,DINUM,X,Y,DIE,DR,DA
 S DIC="^ESP(912.9,",DIC(0)="L",DLAYGO=912.9
 F J=1:1:4 S TEXT=$P($T(NEWREC+J),";;",2) D
 .S DINUM=$P(TEXT,U,1),X=$P(TEXT,U,2),TYPE=$P(TEXT,U,3),CAT=$P(TEXT,U,4)
 .I $D(^ESP(912.9,DINUM,0)),$P(^(0),U,1)=X Q
 .S DIC("DR")=".02////"_TYPE_";.03////"_CAT
 .K DO,DD D FILE^DICN
 .I Y=-1 D
 ..W !!,"File #912.9, filing entry #"_$P(TEXT,U,1)
 ..W !,"   for "_$P(TEXT,U,2)_" was unsuccessful."
 .I +Y>0 D
 ..W !!,"File #912.9, entry #"_$P(TEXT,U,1)
 ..W !,"   for "_$P(TEXT,U,2)_" was successfully filed."
 ;put inactivation dates in entries 23,24,25,26
 S TEXT(23)="ABOVE $100 (GOV'T)"
 S TEXT(24)="BELOW $100 (GOV'T)"
 S TEXT(25)="ABOVE $100 (PERSONAL)"
 S TEXT(26)="BELOW $100 (PERSONAL)"
 F I=23,24,25,26 D
 .I '$D(^ESP(912.9,I,1)) S DIE="^ESP(912.9,",DR="1////2971001",DA=I D ^DIE
 .I $P($G(^ESP(912.9,I,1)),U,1)=2971001 D
 ..W !!,"File #912.9, entry #"_I
 ..W !,"   for "_TEXT(I)_" inactivated"
 ..W !,"   effective October 1, 1997."
 .I $P($G(^ESP(912.9,I,1)),U,1)'=2971001 D
 ..W !!,"File #912.9, entry #"_I
 ..W !,"   for "_TEXT(I)
 ..W !,"   has not been properly inactivated."
 Q
 ;
FILE2 ;update file #915
 N I
 K ^TMP($J,"WP"),^TMP($J,"ERR")
 I $P($G(^ESP(915,55,0)),U,1)'="THEFT-GOVERNMENT PROPERTY" D
 .W !!,"File #915, entry #55"
 .W !,"   ...not updated."
 .W !,"   Field #.01'=THEFT-GOVERNMENT PROPERTY"
 I $P($G(^ESP(915,55,0)),U,1)="THEFT-GOVERNMENT PROPERTY" D
 .F J=1:1:13 S ^TMP($J,"WP",J)=$P($T(UP55+J),";;",2)
 .D WP^DIE(915,"55,",10,,"^TMP($J,""WP"")","^TMP($J,""ERR"")")
 .I $D(^TMP($J,"ERR")) D
 ..W !!,"File #915, entry #55 - THEFT-GOVERNMENT PROPERTY"
 ..W !,"   ...not updated."
 ..W !,"   "_^TMP($J,"ERR","DIERR",1,"TEXT",1)
 .I '$D(^TMP($J,"ERR")) D
 ..W !!,"File #915, entry #55 - THEFT-GOVERNMENT PROPERTY"
 ..W !,"   ...successfully updated."
 K ^TMP($J,"WP"),^TMP($J,"ERR")
 I $P($G(^ESP(915,56,0)),U,1)'="THEFT-PERSONAL PROPERTY" D
 .W !!,"File #915, entry #56"
 .W !,"   ...not updated."
 .W !,"   Field #.01'=THEFT-PERSONAL PROPERTY"
 I $P($G(^ESP(915,56,0)),U,1)="THEFT-PERSONAL PROPERTY" D
 .F J=1:1:14 S ^TMP($J,"WP",J)=$P($T(UP56+J),";;",2)
 .D WP^DIE(915,"56,",10,,"^TMP($J,""WP"")","^TMP($J,""ERR"")")
 .I $D(^TMP($J,"ERR")) D
 ..W !!,"File #915, entry #56 - THEFT-PERSONAL PROPERTY"
 ..W !,"   ...not updated."
 ..W !,"   "_^TMP($J,"ERR","DIERR",1,"TEXT",1)
 .I '$D(^TMP($J,"ERR")) D
 ..W !!,"File #915, entry #56 - THEFT-PERSONAL PROPERTY"
 ..W !,"   ...successfully updated."
 K ^TMP($J,"WP"),^TMP($J,"ERR")
 Q
 ;
CONVERT ;convert file #912 data
 ;for any offense occurring after midnight 9-30-97;
 ;convert any subtype 24 or 26 automatically;
 ;convert any aubtype 23 or 25 only if it's the only subtype and the dollar amount
 ;of property loss is known;
 ;all other cases of subtype 23 or 25 require user intervention.
 N ESDTBEG,ESDTREC,ESIEN,ESSUBT,ESN,ESNN,ESMONEY,ESCNVDT,ESCREAT,ESPURGE,X1,X2
 D NOW^%DTC S Y=$E(%,1,12),ESCNVDT=$$FMTE^XLFDT(Y,"5"),(ESCREAT,X1)=$P(%,".",1),X2=90 D C^%DTC S ESPURGE=X
 ;create the zero node for the temp storage global
 S ^XTMP("ESP",0)=ESPURGE_"^"_ESCREAT_"^temporary storage for ES*1*22"
 ;sort thru "C" xref; check field #.03
 S (ESDTBEG,ESDTREC)=2970930.235959
 F  S ESDTREC=$O(^ESP(912,"C",ESDTREC)) Q:ESDTREC=""  S ESIEN=$O(^(ESDTREC,0)) I ESIEN D
 .Q:'$D(^ESP(912,ESIEN))  Q:$P(^ESP(912,ESIEN,0),"^",3)'>ESDTBEG
 .S ESN=0
 .F  S ESN=$O(^ESP(912,ESIEN,10,ESN)) Q:+ESN=0  D
 ..S ESMONEY=0,ESNN=0 F  S ESNN=$O(^ESP(912,ESIEN,90,ESNN)) Q:+ESNN=0  S ESMONEY=ESMONEY+$P(^(ESNN,0),U,3)
 ..;subtype=23,24,25,26 only
 ..S ESSUBT=$P(^ESP(912,ESIEN,10,ESN,0),U,3) Q:(ESSUBT<23)!(ESSUBT>26)  D
 ...;automatically update any below $100 subtypes
 ...I ESSUBT=24 S $P(^ESP(912,ESIEN,10,ESN,0),U,3)=40,^XTMP("ESP","CONV",ESIEN,ESN)=ESSUBT_"^40^.5^"_ESCNVDT Q
 ...I ESSUBT=26 S $P(^ESP(912,ESIEN,10,ESN,0),U,3)=42,^XTMP("ESP","CONV",ESIEN,ESN)=ESSUBT_"^42^.5^"_ESCNVDT Q
 ...;above $100 subtypes are still to be processed;
 ...;if there is only one classification node and the property loss is known, then convert subtype
 ...I ESN=1,+$O(^ESP(912,ESIEN,10,ESN))=0 D  Q
 ....I ESMONEY>0,ESMONEY<1001 D  Q
 .....I ESSUBT=23 S $P(^ESP(912,ESIEN,10,ESN,0),U,3)=40,^XTMP("ESP","CONV",ESIEN,ESN)=ESSUBT_"^40^.5^"_ESCNVDT Q
 .....I ESSUBT=25 S $P(^ESP(912,ESIEN,10,ESN,0),U,3)=42,^XTMP("ESP","CONV",ESIEN,ESN)=ESSUBT_"^42^.5^"_ESCNVDT Q
 ....I ESMONEY>1000 D  Q
 .....I ESSUBT=23 S $P(^ESP(912,ESIEN,10,ESN,0),U,3)=39,^XTMP("ESP","CONV",ESIEN,ESN)=ESSUBT_"^39^.5^"_ESCNVDT Q
 .....I ESSUBT=25 S $P(^ESP(912,ESIEN,10,ESN,0),U,3)=41,^XTMP("ESP","CONV",ESIEN,ESN)=ESSUBT_"^41^.5^"_ESCNVDT Q
 ....;if still not processed, then this subtype conversion requires user intervention
 ....S ^XTMP("ESP","USER",ESIEN,ESN)=ESSUBT_"^"_ESMONEY
 ...;if esn'=1 or esn=1 but multiple
 ...S ^XTMP("ESP","USER",ESIEN,ESN)=ESSUBT_"^"_ESMONEY
 Q
 ;
NEWREC ;new file entries for file #912.9
 ;;39^ABOVE $1000 (GOV'T)^46^11
 ;;40^BELOW $1000 (GOV'T)^46^11
 ;;41^ABOVE $1000 (PERSONAL)^47^11
 ;;42^BELOW $1000 (PERSONAL)^47^11
 ;
UP55 ;update record #55 in file #915
 ;;Whoever embezzles, steals, purloins, or knowingly converts to his use
 ;;or the use of another, or without authority, sells, conveys or
 ;;disposes of any record, voucher, money, or thing of value of the
 ;;United States or of any department or agency thereof, or any property
 ;;made or being made under contract for the United States or any
 ;;department or agency thereof, or Whoever receives, conceals or retains
 ;;the same with intent to convert it to his use or gain, knowing it to
 ;;have been embezzled, stolen, purloined or converted---Shall be fined
 ;;not more than $10,000 or imprisoned not more than ten years, or both;
 ;;but if the value of such property does not exceed the sum of $1000, he
 ;;shall be fined not more than $1,000 or imprisoned not more than one
 ;;year, or both.  The word "value" means face, par or market value, or
 ;;cost price, either wholesale or retail; whichever is greater.
 ;
UP56 ;update record #56 in file #915
 ;;Whoever, within the special maritime and territorial jurisdiction
 ;;of the United States, takes and carries away, with intent to steal
 ;;or purloin, any personal property of another, shall be punished as
 ;;follows:  If the property taken is of a value exceeding $1000, or is
 ;;taken from the person of another, by a fine of not more than $5,000,
 ;;or imprisonment for not more than five years, or both; in all other
 ;;cases by a fine of not more than $1,000 or by imprisonment not
 ;;more than one year, or both.  If the property stolen consists of any
 ;;evidence of debt, or other written instrument, the amount of money
 ;;due thereon, or secured to be paid thereby and remaining unsatisfied,
 ;;or which in any contingency might be collected thereon, or the value
 ;;of the property the title to which is shown thereby, or the sum
 ;;which might be recovered in the absence thereof, shall be the value
 ;;of the property stolen.
 ;
