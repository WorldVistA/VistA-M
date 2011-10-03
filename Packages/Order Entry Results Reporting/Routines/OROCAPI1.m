OROCAPI1 ; JMH - ORDER CHECK INSTANCES File APIs;8/24/07 ;03/14/11  09:32
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**293,346**;Dec 17, 1997;Build 5
SAVEOC(ORL,RET) ;SAVE A GROUP OF ORDER CHECKS
         ;ORL=LIST OF ORDER CHECKS
         ;(D0,1)=ORDER NUMBER (FILE 100)^
         ;       OCCURANCE DESCRIPTOR^
         ;       USER (FILE 200)^
         ;       OCCURANCE D/T^
         ;       ORDER CHECK NUMBER (FILE 100.8)^
         ;       CLINICAL DANGER LEVEL
         ;   (D0,2)=ORDER CHECK NARRATIVE
         ;   (D0,3)=OVERRIDE REASON
         ;RET=RETURN ARRAY OF IENS BY ORL(D0)
         ;    RET(D0,IEN)=""
         N I S I=0 F  S I=$O(ORL(I)) Q:'I  D
         .N DA,DR,DIC,X,Y,DIE,ORSTATUS,ORN,ORDANG,DW,DV,%,D,DC,DE,DH,DI,DIEL,DIFLD,DIP,DK,DM,DP,DQ
         .S ORN=+ORL(I,1)
         .Q:'ORN!('$D(^OR(100,ORN)))
         .Q:'$P(ORL(I,1),U,5)  ;QUIT IF NO ORDER CHECK NUMBER
         .Q:'$L($G(ORL(I,2)))  ;QUIT IF NO ORDER CHECK TEXT
         .S DIC="^ORD(100.05,",DIC(0)="F",X=ORN D FILE^DICN
         .Q:'DA
         .S RET(I,DA)=""
         .S DIE=DIC,ORSTATUS=$P($G(^OR(100,ORN,3)),U,3),ORDANG=$S($P($G(ORL(I,1)),U,6):$P($G(ORL(I,1)),U,6),1:$$GET^XPAR("ALL","ORK CLINICAL DANGER LEVEL",$P($G(ORL(I,1)),U,5),"I"))
         .S DR="1////"_ORSTATUS_";2////"_$P($G(ORL(I,1)),U,2)_";3////"_$P($G(ORL(I,1)),U,3)_";4////"_$P($G(ORL(I,1)),U,4)_";5////"_$P($G(ORL(I,1)),U,5)_";6////"_ORDANG_";8///"_$TR($G(ORL(I,2)),";",",")_";7///"_$TR($G(ORL(I,3)),";",",")
         .D ^DIE
         .;set ^ORD(100.05,DA,2) if ORL(DO,2,1) exists
         .I $D(ORL(I,2))=11 N J S J=0 F  S J=$O(ORL(I,2,J)) Q:'J  S ^ORD(100.05,DA,2,J+1,0)=ORL(I,2,J)
         Q
GETOC1(IEN,RET) ;GET A SINGLE ORDER CHECK
         ;IEN = 100.05 IEN
         ;RET = RETURNED 100.05 DATA FOR IEN
         K RET
         Q:'$G(IEN)
         Q:'$D(^ORD(100.05,IEN))
         S RET(IEN,0)=$G(^ORD(100.05,IEN,0))
         S RET(IEN,1)=$G(^ORD(100.05,IEN,1))
         M RET(IEN,"OC")=^ORD(100.05,IEN,2)
         K RET(IEN,"OC",0)
         M RET(IEN,"OR")=^ORD(100.05,IEN,3)
         K RET(IEN,"OR",0)
         Q
GETOC2(ORD,RET) ;GET ALL 100.05 IENS FOR A SPECIFIC ORDER
         ;ORD = 100 IEN
         ;RET = LIST OF 100.05 IENS
         K RET
         Q:'$G(ORD)
         N I S I=0 F  S I=$O(^ORD(100.05,"B",ORD,I)) Q:'I  S RET(ORD,I)=""
         Q
GETOC3(ORD,OCC,RET) ;GET ALL 100.05 IENS FOR A SPECIFIC ORDER/OCCURANCE PAIR
         ;ORD = 100 IEN
         ;OCC = OCCURANCE STRING
         ;RET = LIST OF 100.05 IENS
         K RET
         Q:'$G(ORD)
         Q:'$L(OCC)
         N I S I=0 F  S I=$O(^ORD(100.05,"C",ORD,OCC,I)) Q:'I  S RET(ORD,I)=""
         Q
GETOC4(ORD,RET) ;GET DATA FOR ALL 100.05 RECORDS OF A SPECIFIC ORDER
         ;ORD = 100 IEN
         ;RET = LIST OF 100.05 IENS
         K RET
         Q:'$G(ORD)
         N RET2
         D GETOC2(ORD,.RET)
         Q:'$D(RET)
         N I S I=0 F  S I=$O(RET(ORD,I)) Q:'I  D
         .D GETOC1(I,.RET2)
         .M RET(ORD,"DATA")=RET2
         Q
GETOC5(ORD,OCC,RET) ;GET DATA FOR ALL 100.05 RECORDS OF A SPECIFIC ORDER/OCCURANCE PAIR
         ;ORD = 100 IEN
         ;OCC = OCCURANCE STRING
         ;RET = LIST OF 100.05 IENS WITH DATA
         K RET
         Q:'$G(ORD)
         Q:'$L(OCC)
         N RET2
         D GETOC3(ORD,OCC,.RET)
         Q:'$D(RET)
         N I S I=0 F  S I=$O(RET(ORD,I)) Q:'I  D
         .D GETOC1(I,.RET2)
         .M RET(ORD,"DATA")=RET2
         Q
CONVERT ;CONVERT EXISTING FILE 100 NODE 9 ENTRIES OVER TO FILE 100.05
 N I,J,ORK,DESC
 S I=0
 I $G(^XTMP("ORK FILE CONVERSION")) S I=+^XTMP("ORK FILE CONVERSION")
 F  S I=$O(^OR(100,I)) Q:'I  I $D(^OR(100,I,9)) I '$D(^ORD(100.05,"B",I)) D CONVERT1(I)
 S I=0
 F  S I=$O(^XTMP("ORK FILE CONVERSION","ERRORS",I)) Q:'I  D DELETE(I)
 K ^XTMP("ORK FILE CONVERSION","LAST ERRORS")
 M ^XTMP("ORK FILE CONVERSION","LAST ERRORS")=^XTMP("ORK FILE CONVERSION","ERRORS")
 K ^XTMP("ORK FILE CONVERSION","ERRORS")
 S ^XTMP("ORK FILE CONVERSION")=0
 D MAIL
 Q
CONVERT1(I) ;CONVERT EXISTING FILE 100 NODE 9 ENTRIES OVER TO FILE 100.05 FOR 1 ORDER
 N $ETRAP,$ESTACK
 S $ETRAP="D ERR^OROCAPI1 Q"
 N J,ORK,DESC,RET
 S DESC="SIGNATURE_CPRS"
 S ^XTMP("ORK FILE CONVERSION",0)=$$FMADD^XLFDT($$NOW^XLFDT,90)_U_$$NOW^XLFDT
 I ",11,13,14,"[(","_$P($G(^OR(100,I,3)),U,3)_",") S DESC="ACCEPTANCE_CPRS"
 S J=0 F  S J=$O(^OR(100,I,9,J)) Q:'J  D
 .N X0,X1 S X0=$G(^OR(100,I,9,J,0)),X1=$G(^OR(100,I,9,J,1))
 .N ORKDT S ORKDT=$S($P(X0,U,6):$P(X0,U,6),1:$P($G(^OR(100,I,0)),U,7))
 .S ORK(J,1)=I_U_DESC_U_$P(X0,U,5)_U_ORKDT_U_$P(X0,U)
 .S ORK(J,2)=X1
 .S ORK(J,3)=$P(X0,U,4)
 I $D(ORK) D SAVEOC^OROCAPI1(.ORK,.RET)
 S ^XTMP("ORK FILE CONVERSION")=I
 Q
COPY(ORD1,ORD2) ;COPY THE ORDER CHECKS FROM ORDER 1 TO ORDER 2
 N RET,ORK,I
 D GETOC4(ORD1,.RET) S I=0 F  S I=$O(RET(ORD1,"DATA",I)) Q:'I  D
 .S ORK(I,1)=ORD2_U_$P($G(RET(ORD1,"DATA",I,0)),U,3)_U_$P($G(RET(ORD1,"DATA",I,0)),U,4)_U_$P($G(RET(ORD1,"DATA",I,0)),U,5)_U_$P($G(RET(ORD1,"DATA",I,1)),U,1)
 .S ORK(I,2)=$G(RET(ORD1,"DATA",I,"OC",1,0))
 .S ORK(I,3)=$G(RET(ORD1,"DATA",I,"OR",1,0))
 D SAVEOC(.ORK)
 Q
OCCNT(ORD) ;RETURN 1 IF THERE ARE ORDER CHECKS AND 0 IF NOT
 N RET,Y D GETOC2(ORD,.RET)
 S Y=0 I $D(RET) S Y=1
 Q Y
DELETE(ORD) ;DELETE ALL OF THE OC INSTANCES FOR AN ORDER
 N RET,I,DIK,DA D GETOC2(ORD,.RET)
 S I=0 F  S I=$O(RET(ORD,I)) Q:'I  S DA=I,DIK="^ORD(100.05," D ^DIK
 Q
DELOCC(ORD,OCC) ;DELETE ALL OF THE OC INSTANCES FOR AN ORDER/OCCURANCE PAIR
 N RET,I,DIK,DA D GETOC3(ORD,OCC,.RET)
 S I=0 F  S I=$O(RET(ORD,I)) Q:'I  S DA=I,DIK="^ORD(100.05," D ^DIK
 Q
ERR ;
 S ^XTMP("ORK FILE CONVERSION","ERRORS",ORN)=""
 S ^XTMP("ORK FILE CONVERSION")=ORN
 D UNWIND^%ZTER
 Q
MAIL ;send mail message to installer if any errors encountered during conversion process
 Q:'$D(^XTMP("ORK FILE CONVERSION","LAST ERRORS"))
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,XMMG,ORTXT,I,J
 S XMDUZ="PATCH OR*3*293 ORDER CHECK CONVERSION" S:$G(DUZ) XMY(^XTMP("ORK FILE CONVERSION","INSTALLER"))=""
 S I=0,I=I+1,^TMP($J,"ORTXT",I)=""
 S I=I+1,^TMP($J,"ORTXT",I)="While converting order check information from file 100 node 9 over to file"
 S I=I+1,^TMP($J,"ORTXT",I)="100.05, data errors were discovered for the order numbers listed below."
 S I=I+1,^TMP($J,"ORTXT",I)="All other order data converted appropriately."
 S I=I+1,^TMP($J,"ORTXT",I)="We recommend correcting the data, and then re-running the"
 S I=I+1,^TMP($J,"ORTXT",I)="conversion utility from programmer prompt as follows:"
 S I=I+1,^TMP($J,"ORTXT",I)="    D CONVERT^OROCAPI1"
 S I=I+1,^TMP($J,"ORTXT",I)="NOTE: re-running the conversion utility will only convert those orders that"
 S I=I+1,^TMP($J,"ORTXT",I)="did not convert properly the first time."
 S I=I+1,^TMP($J,"ORTXT",I)=""
 S I=I+1,^TMP($J,"ORTXT",I)="LIST OF ORDERS WITH CORRUPTED ORDER CHECK DATA"
 S I=I+1,^TMP($J,"ORTXT",I)="=============================================="
 S J=0 F  S J=$O(^XTMP("ORK FILE CONVERSION","LAST ERRORS",J)) Q:'J  S I=I+1,^TMP($J,"ORTXT",I)=J
 S XMTEXT="^TMP($J,""ORTXT"",",XMSUB="PATCH OR*3*293 CONVERSION ERRORS!"
 D ^XMD
 Q
