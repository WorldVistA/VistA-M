EASEZF3 ;ALB/jap - Filing 1010EZ Data to Patient Database ;10/31/00  13:07
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**1,57,100**;Mar 15, 2001;Build 6
 ;
SP ;file Spouse data
 N C,MULTIPLE,FILE,SUBFILE,FLD,XDATA,ACCEPT,SUBIEN,SEX,EZDATA,EAS,ERR
 N KEY,X,Y,XLINK,DIC
 ;process sequence must be 408.13 - 408.12 - 408.21 - 408.22
 ;set sex of spouse
 S KEY=+$$KEY711^EASEZU1("APPLICANT SEX")
 S X=$$DATA712^EASEZU1(EASAPP,KEY,1),APSEX=$P(X,U,1),SEX=$S(APSEX="M":"FEMALE",1:"MALE")
 S XLINK=$G(FLINK("SP",1,408.13)),PTDATA="" I XLINK D
 .S FFF="408.13^408.13^.02" S PTDATA=$$GET^EASEZC1(XLINK,FFF)
 .S SP(1,408.13,408.13,.02)=SEX_U_2_U_U_PTDATA_U_XLINK
 ;
 F FILE=408.13,408.12,408.21,408.22 D
 .S MULTIPLE=1,SUBFILE=FILE,FLD=""
 .S XLINK=$G(FLINK("SP",MULTIPLE,FILE))
 .;record in file #408.13 is needed for all further data filng
 .Q:(FILE'=408.13)&('$G(FLINK("SP",MULTIPLE,408.13)))
 .;for data elements with link to database, 
 .;only file 1010EZ data if accepted by user;
 .;data in external format
 .I XLINK D
 ..;when #408.12 record exists, don't try to update subfile #408.1275
 ..S FLD="" F  S FLD=$O(SP(MULTIPLE,FILE,SUBFILE,FLD)) Q:FLD=""  D
 ...S XDATA=SP(MULTIPLE,FILE,SUBFILE,FLD),ACCEPT=$P(XDATA,U,2)
 ...I FILE=408.13,FLD=.09 S XDATA=$TR(XDATA,"-","")
 ...I ACCEPT D LINK^EASEZF2(XDATA,FILE,FLD,"SP",MULTIPLE)
 .;for data elements with no link to database, 
 .;always create new record(s) to store 1010EZ data;
 .;put data in internal format
 .I 'XLINK D
 ..K EAS,ERR
 ..;supplement data and convert to internal format
 ..S FLD="" F  S FLD=$O(SP(MULTIPLE,FILE,SUBFILE,FLD)) Q:FLD=""  D
 ...S EZDATA=$P(SP(MULTIPLE,FILE,SUBFILE,FLD),U,1)
 ...S EAS(EASAPP,FILE,"+1,",FLD)=EZDATA
 ..I FILE=408.13 D
 ...S X=$G(EAS(EASAPP,FILE,"+1,",".03")) I X'="" D ^%DT S EAS(EASAPP,FILE,"+1,",".03")=Y
 ...S X=$G(EAS(EASAPP,FILE,"+1,",".09")) I X'="" D
 ....S SSN=$TR(X,"-","") S EAS(EASAPP,FILE,"+1,",".09")=SSN
 ....I $D(^DGPR(408.13,"SSN",SSN)) S EAS(EASAPP,FILE,"+1,",".09")=""
 ...S KEY=+$$KEY711^EASEZU1("APPLICANT SEX")
 ...S X=$P($$DATA712^EASEZU1(EASAPP,KEY,1),U,1),SEX=$S(X="M":"F",1:"M")
 ...S EAS(EASAPP,FILE,"+1,",".02")=SEX
 ...S X=$G(EAS(EASAPP,FILE,"+1,","1.6")) I X'="" D
 ....S DIC=5,DIC(0)="X" D ^DIC
 ....S EAS(EASAPP,FILE,"+1,","1.6")=$S(+Y:+Y,1:"")
 ..I FILE=408.12,$G(FLINK("SP",MULTIPLE,408.13)) D F40812("SP",1)
 ..I FILE=408.21,$G(FLINK("SP",MULTIPLE,408.12)) D
 ...S EAS(EASAPP,FILE,"+1,",".01")=INCYR
 ...S EAS(EASAPP,FILE,"+1,",".02")=FLINK("SP",MULTIPLE,408.12)
 ...S EAS(EASAPP,FILE,"+1,","101")=DUZ
 ...S EAS(EASAPP,FILE,"+1,","102")=DT
 ...S EAS(EASAPP,FILE,"+1,","103")=DUZ
 ...S EAS(EASAPP,FILE,"+1,","104")=DT
 ..I FILE=408.22,$G(FLINK("SP",MULTIPLE,408.21)) D
 ...S EAS(EASAPP,FILE,"+1,",".01")=EASDFN
 ...S EAS(EASAPP,FILE,"+1,",".02")=FLINK("SP",MULTIPLE,408.21)
 ..I FILE'=408.12 D
 ...S FLINK("SP",MULTIPLE,FILE)=$$NOLINK^EASEZF2(.EAS,"SP",MULTIPLE)
 ...S FLD="" F  S FLD=$O(SP(MULTIPLE,FILE,SUBFILE,FLD)) Q:FLD=""  D
 ....S $P(SP(MULTIPLE,FILE,SUBFILE,FLD),U,5)=FLINK("SP",MULTIPLE,FILE)
 Q
 ;
F40812(TYPE,MULT) ;create a new record in file #408.12
 ;input TYPE = "SP" for Souse or "CN" for Child
 ;      MULT = always 1 for spouse; or
 ;             1st subscript of CN array for child
 ;can't use normal FileMan data entry
 N C,ARR,FILE,SUBFILE,FLD,DGPRIEN,XDATE,SUBIEN,RELATE,XX,X,Y,DA,DIK,EAS,ERR
 S DGPRIEN=""
 S ARR=TYPE
 S FILE=408.12,SUBFILE=408.12
 I TYPE="SP" S RELATE=2
 I TYPE="CN" D
 .S X=$P($G(CN(MULT,FILE,SUBFILE,".02")),U,1)
 .S RELATE=$S(X="SON":3,X="DAUGHTER":4,X="STEPSON":5,X="STEPDAUGHTER":6,1:99)
 ;verify that no record points to known file #408.13 record
 S C=FLINK(TYPE,MULT,408.13)_";DGPR(408.13,"
 I $D(^DGPR(408.12,"C",C)) S DGPRIEN=$O(^DGPR(408.12,"C",C,0))
 ;if it does, quit w/o filing
 Q:DGPRIEN
 ;otherwise create a new entry
 L +^DGPR(408.12,0):30
 K DA,DIK
 S DGPRIEN=$P(^DGPR(408.12,0),U,3)+1,$P(^DGPR(408.12,0),U,3)=DGPRIEN
 S ^DGPR(408.12,DGPRIEN,0)=EASDFN_U_RELATE_U_C
 S DA=DGPRIEN,DIK="^DGPR(408.12,",DIK(1)=".01^" D EN^DIK S DIK(1)=".03" D EN^DIK
 S X=$P(^DGPR(408.12,0),U,4),$P(^DGPR(408.12,0),U,4)=X+1
 L -^DGPR(408.12,0)
 S FLINK(TYPE,MULT,408.12)=DGPRIEN
 ;don't continue if file#408.12 record doesn't exist
 Q:'$G(FLINK(TYPE,MULT,408.12))
 ;store the link in subfile #712.01 record
 S FLD="" F  S FLD=$O(@ARR@(MULT,FILE,SUBFILE,FLD)) Q:FLD=""  D
 .S SUBIEN=$P(@ARR@(MULT,FILE,SUBFILE,FLD),U,3)
 .S $P(@ARR@(MULT,FILE,SUBFILE,FLD),U,5)=FLINK(TYPE,MULT,FILE)
 ;there's never more than one array node for subfile #408.1275; for field #.01;
 S SUBFILE=408.1275,FLD=".01"
 S XX=$G(@ARR@(MULT,FILE,SUBFILE,FLD))
 K EAS
 S XDATE=$P(XX,U,1)
 S SUBIEN=$P(XX,U,3)
 Q:XDATE=""
 S X=XDATE D ^%DT S XDATE=Y
 S EAS(EASAPP,SUBFILE,"+1,"_FLINK(TYPE,MULT,408.12)_",",".01")=XDATE
 S EAS(EASAPP,SUBFILE,"+1,"_FLINK(TYPE,MULT,408.12)_",",".02")=1
 S FLINK(TYPE,MULT,SUBFILE)=$$NOLINK^EASEZF2(.EAS,TYPE,MULT)
 Q:FLINK(TYPE,MULT,SUBFILE)=""
 ;store link to new subrecord in subfile #712.01
 S $P(@ARR@(MULT,FILE,SUBFILE,FLD),U,5)=FLINK(TYPE,MULT,FILE)_";"_FLINK(TYPE,MULT,SUBFILE)
 Q
