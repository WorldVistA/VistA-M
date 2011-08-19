EASEZF4 ;ALB/jap - Filing 1010EZ Data to Patient Database ;10/31/00  13:07
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**1,51,57,70**;Mar 15, 2001;Build 26
 ;
CN ;file Dependent/Child data
 N MULTIPLE,FILE,SUBFILE,FLD,XDATA,ACCEPT,SUBIEN,SEX,SSN,EZDATA,EAS,ERR,X,Y
 ;process sequence must be 408.13 - 408.12 - 408.21 - 408.22
 S MULTIPLE=0 F  S MULTIPLE=$O(CN(MULTIPLE)) Q:'MULTIPLE  F FILE=408.13,408.12,408.21,408.22 D
 . S SUBFILE=FILE,FLD=""
 . S XLINK=$G(FLINK("CN",MULTIPLE,FILE))
 . ;record in file #408.13 is needed for all further data filng
 . Q:(FILE'=408.13)&('$G(FLINK("CN",MULTIPLE,408.13)))
 . ;for data elements with link to database, 
 . ;only file 1010EZ data if accepted by user;
 . ;data in external format
 . I XLINK D
 . . ;when #408.12 record exists, don't try to update subfile #408.1275
 . . S FLD="" F  S FLD=$O(CN(MULTIPLE,FILE,SUBFILE,FLD)) Q:FLD=""  D
 . . . S XDATA=CN(MULTIPLE,FILE,SUBFILE,FLD),ACCEPT=$P(XDATA,U,2)
 . . . I FILE=408.13,FLD=.09 S XDATA=$TR(XDATA,"-","")
 . . . I ACCEPT D LINK^EASEZF2(XDATA,FILE,FLD,"CN",MULTIPLE)
 . ;for data elements with no link to database, 
 . ;always create new record(s) to store 1010EZ data;
 . ;put data in internal format
 . I 'XLINK D
 . . K EAS,ERR
 . . S FLD="" F  S FLD=$O(CN(MULTIPLE,FILE,SUBFILE,FLD)) Q:FLD=""  D
 . . . S EZDATA=$P(CN(MULTIPLE,FILE,SUBFILE,FLD),U,1)
 . . . S EAS(EASAPP,FILE,"+1,",FLD)=EZDATA
 . . ;supplement data and convert to internal format
 . . I FILE=408.13 D
 . . . S X=$G(EAS(EASAPP,FILE,"+1,",".03")) I X'="" D ^%DT S EAS(EASAPP,FILE,"+1,",".03")=Y
 . . . S X=$G(EAS(EASAPP,FILE,"+1,",".09")) I X'="" D
 . . . . S SSN=$TR(X,"-","") S EAS(EASAPP,FILE,"+1,",".09")=SSN
 . . . . I $D(^DGPR(408.13,"SSN",SSN)) S EAS(EASAPP,FILE,"+1,",".09")=""
 . . . S X=$P($G(CN(MULTIPLE,408.12,408.12,.02)),U,1) S SEX=$S(X["SON":"M",X["DAUGHTER":"F",1:"")
 . . . I SEX'="" S EAS(EASAPP,FILE,"+1,",".02")=SEX
 . . I FILE=408.12,$G(FLINK("CN",MULTIPLE,408.13)) D F40812^EASEZF3("CN",MULTIPLE)
 . . I FILE=408.21,$G(FLINK("CN",MULTIPLE,408.12)) D
 . . . S EAS(EASAPP,FILE,"+1,",".01")=INCYR
 . . . S EAS(EASAPP,FILE,"+1,",".02")=FLINK("CN",MULTIPLE,408.12)
 . . . S EAS(EASAPP,FILE,"+1,","101")=DUZ
 . . . S EAS(EASAPP,FILE,"+1,","102")=DT
 . . . S EAS(EASAPP,FILE,"+1,","103")=DUZ
 . . . S EAS(EASAPP,FILE,"+1,","104")=DT
 . . I FILE=408.22,$G(FLINK("CN",MULTIPLE,408.21)) D
 . . . S EAS(EASAPP,FILE,"+1,",".01")=EASDFN
 . . . S EAS(EASAPP,FILE,"+1,",".02")=FLINK("CN",MULTIPLE,408.21)
 . . . S X=$P($G(CN(MULTIPLE,FILE,SUBFILE,".1")),U,1) I X S EAS(EASAPP,FILE,"+1,",".1")="Y"
 . . . ;EAS*1.0*57 - ALLOW NULL VALUES FOR .09 AND .18
 . . . S X=$P($G(CN(MULTIPLE,FILE,SUBFILE,".09")),U,1),EAS(EASAPP,FILE,"+1,",".09")=$S(X["Y":1,X["N":0,1:"")
 . . . S X=$P($G(CN(MULTIPLE,408.21,408.21,".14")),U,1) I X S EAS(EASAPP,FILE,"+1,",".11")=1
 . . . S X=$P($G(CN(MULTIPLE,FILE,SUBFILE,".18")),U,1),EAS(EASAPP,FILE,"+1,",".18")=$S(X["Y":1,X["N":0,1:"")
 . . . S X=$G(EAS(EASAPP,FILE,"+1,",".1"))
 . . . S EAS(EASAPP,FILE,"+1,",".1")=$S(X="YES":1,X="NO":0,1:"")
 . . . S X=$G(EAS(EASAPP,FILE,"+1,",".06"))
 . . . S EAS(EASAPP,FILE,"+1,",".06")=$S(X="YES":1,X="NO":0,1:"")
 . . I FILE'=408.12 D
 . . . S FLINK("CN",MULTIPLE,FILE)=$$NOLINK^EASEZF2(.EAS)
 . . . S FLD="" F  S FLD=$O(CN(MULTIPLE,FILE,SUBFILE,FLD)) Q:FLD=""  D
 . . . . S $P(CN(MULTIPLE,FILE,SUBFILE,FLD),U,5)=FLINK("CN",MULTIPLE,FILE)
 Q
 ;
LINKUP ;
 N SUBIEN,KEYIEN,MULTIPLE,FILE,SUBFILE,FIELD,DATAKEY,DATANM,TYPE,LINK,X
 S SUBIEN=0 F  S SUBIEN=$O(^EAS(712,EASAPP,10,SUBIEN)) Q:+SUBIEN=0  D
 . S X=$G(^EAS(712,EASAPP,10,SUBIEN,1))
 . ;quit if no data to file
 . Q:(($P(X,U,1)="")&($P(X,U,2)=""))
 . S TYPE=""
 . S KEYIEN=$P(^EAS(712,EASAPP,10,SUBIEN,0),U,1),MULTIPLE=$P(^(0),U,2)
 . S DATANM=$P(^EAS(711,KEYIEN,0),U,1),DATAKEY=$P(^(0),U,2),FILE=$P(^EAS(711,KEYIEN,1),U,1),SUBFILE=$P(^(1),U,2),FIELD=$P(^(1),U,3)
 . Q:FILE<408
 . Q:FILE>408.22
 . I SUBFILE=408.1275 S FILE=SUBFILE
 . I DATANM["CHILD" S TYPE="CN"
 . I DATANM["ASSET(N)" S TYPE="CN"   ;EAS*1.0*70
 . I DATANM["CHILD(N)" D
 . . ;necessary because some version 6 income data for child1 is brought-in via a child(n) multiple
 . . S MULTIPLE=MULTIPLE+1
 . . Q:$G(EASVRSN)<6
 . . ;EAS*1.0*70 -- added up-arrows on next line
 . . I FILE=408.21,("^.08^.14^.17^"[("^"_FIELD_"^")) S MULTIPLE=MULTIPLE-1
 . I DATANM["SPOUSE" S TYPE="SP"
 . I TYPE="" S TYPE="AP"
 . S LINK=$G(FLINK(TYPE,MULTIPLE,FILE))
 . Q:'LINK
 . Q:$$SUPPRESS^EASEZU4(EASAPP,DATAKEY,1,$G(EASVRSN))
 . I FILE=408.1275 S LINK=FLINK(TYPE,MULTIPLE,408.12)_";"_FLINK(TYPE,MULTIPLE,FILE)
 . S $P(^EAS(712,EASAPP,10,SUBIEN,2),U,2)=LINK
 Q
