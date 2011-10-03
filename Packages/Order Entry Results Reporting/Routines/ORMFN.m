ORMFN ; SLC/MKB - MFN msg router ;8/18/2010
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**26,97,94,176,215,243,280**;Dec 17, 1997;Build 85
EN(MSG) ; -- main entry point for OR ITEM RECEIVE
 N ORMSG,ORNMSP,ORDG,LEN,MSH,MFI,MFE,ZPKG,ZSY,NTE,ORMFE,ORDITEM,ORACTION,ORDIFN,ORFIEN,ORFLD,ORFDA,NUM,VALUE,X,Y,DA,DIC,DIK,SYS,ZLC,LAST,NAME,ID,INACTIVE,I,ORY,NEXT,DD,DO
 ;AGP Create a before and after temp global for compares by other protocols
 K ^TMP($J,"OR OI BEFORE"),^TMP($J,"OR OI AFTER"),^TMP($J,"OR OI NEW")
 S ORMSG=$G(MSG,"MSG") Q:'$O(@ORMSG@(0))  ; msg array root
 N ORNOW S ORNOW=$$NOW^XLFDT ;M ^XTMP("OR ITEM RECEIVE",ORNOW)=@ORMSG
MSH S MSH=0 F  S MSH=$O(@ORMSG@(MSH)) Q:MSH'>0  Q:$E(@ORMSG@(MSH),1,3)="MSH"
 Q:'MSH  S MSH=MSH_U_@ORMSG@(MSH)
 S X=$P(MSH,"|",3) S:X="RADIOLOGY" X="IMAGING"
 S ORDG=$O(^ORD(100.98,"B",X,0)),ORNMSP=$$NMSP(X) Q:'$L(ORNMSP)
 S MFI=$O(@ORMSG@(+MSH)) Q:$E(@ORMSG@(MFI),1,3)'="MFI"  ; error
MFE S MFE=+MFI ; ** loop through each MFE segment
 F  S MFE=$O(@ORMSG@(+MFE)) Q:MFE'>0  I $E(@ORMSG@(MFE),1,3)="MFE" D
 . K ORFLD,ORFDA
 . S MFE=MFE_U_@ORMSG@(MFE),ORMFE=$P(MFE,"|",2),INACTIVE=$P(MFE,"|",4)
 . S ORDITEM=$P(MFE,"|",5),NAME=$TR($P(ORDITEM,U,5),"~"," ")
 . ;AGP remove automatic stripping of trailing spaces
 . ;S LEN=$L(NAME) I $E(NAME,LEN)=" " S NAME=$E(NAME,1,(LEN-1))
 . S ID=$P(ORDITEM,U,4)_";"_$P(ORDITEM,U,6)
 . S ORDIFN=+$O(^ORD(101.43,"ID",ID,0)),ORFIEN=ORDIFN_","
 . S ORACTION=$S(ORMFE="MAD":1,(ORMFE="MAC")&('ORDIFN):1,(ORMFE="MUP")&('ORDIFN):1,'ORDIFN:0,ORMFE="MAC":2,ORMFE="MUP":2,ORMFE="MDC":3,ORMFE="MDL":3,1:0) ; 1=add, 2=change, 3=delete (inactivate)
 . Q:'ORACTION  ; 0=error
 . I ORACTION=3 S ORFDA(101.43,ORFIEN,.1)=$S(INACTIVE:$$HL7TFM^XLFDT(INACTIVE),1:$$NOW^XLFDT) D FILE^DIE("K","ORFDA") Q
ADD . I ORACTION=1,'ORDIFN D  Q:'ORDIFN  ;create item if it doesn't exist
 . . S ORDIFN=$$CREATE(NAME),ORFIEN=ORDIFN_","
 . . S ORFDA(101.43,ORFIEN,5)=+ORDG
 . . I ORDIFN>0 S ^TMP($J,"OR OI NEW",ORDIFN)=""
 . I '$D(^TMP($J,"OR OI NEW",ORDIFN)) M ^TMP($J,"OR OI BEFORE",ORDIFN)=^ORD(101.43,ORDIFN)
 . S ORFLD(.01)=NAME,ORFLD(1.1)=NAME,ORFLD(2)=ID,ORFLD(3)=$P(ORDITEM,U)
 . S SYS=$P(ORDITEM,U,3),ORFLD(4)=$S(+SYS=99:$E(SYS,3,99),1:SYS)
 . S ORFLD(.1)=$S(ORMFE="MAC":"@",(ORMFE="MUP")&('INACTIVE):"@",INACTIVE:$$HL7TFM^XLFDT(INACTIVE),1:"")
 . F NUM=.01,.1,1.1,2,3,4 S VALUE=$S(ORFLD(NUM)="":"@",1:ORFLD(NUM)) D VAL^DIE(101.43,ORFIEN,NUM,"F",VALUE,.ORY,"ORFDA")
ZPKG . S LAST=+MFE,ZPKG=$O(@ORMSG@(+MFE))
 . I ZPKG,$E(@ORMSG@(ZPKG),1,3)=("Z"_ORNMSP) S ZPKG=ZPKG_U_@ORMSG@(ZPKG),LAST=+ZPKG D @ORNMSP ; ZXX segment
 . D FILE^DIE("K","ORFDA") ; file data
ZLC . S NEXT=$O(@ORMSG@(LAST)) I NEXT,$E(@ORMSG@(NEXT),1,3)="ZLC" D
 . . N COMP,CID,CODE,CSYS
 . . K DA,^ORD(101.43,ORDIFN,10) ;S DIC("P")=$P(^DD(101.43,10,0),U,2)
 . . S DA(1)=ORDIFN,DIC="^ORD(101.43,"_DA(1)_",10,",DIC(0)="L",ZLC=LAST
 . . F  S ZLC=$O(@ORMSG@(ZLC)) Q:ZLC'>0  Q:$E(@ORMSG@(ZLC),1,3)'="ZLC"  D
 . . . S COMP=$P(@ORMSG@(ZLC),"|",5),X=$P(COMP,U,5) I X="" S LAST=ZLC Q
 . . . S CID=$P(COMP,U,4)_";"_$P(COMP,U,6) K DIC("DR"),DO,DD
 . . . S CODE=$P(COMP,U),CSYS=$P(COMP,U,3) S:+CSYS=99 CSYS=$E(CSYS,3,99)
 . . . S DIC("DR")="2///^S X=CID;3///^S X=CODE;4///^S X=CSYS"
 . . . D FILE^DICN S LAST=ZLC
ZSY . I $D(^ORD(101.43,ORDIFN,2)) D  ; kill old ones first
 . . S DA(1)=ORDIFN,DIK="^ORD(101.43,"_DA(1)_",2,"
 . . S DA=0 F  S DA=$O(^ORD(101.43,DA(1),2,DA)) Q:DA'>0  D ^DIK
 . . K ^ORD(101.43,ORDIFN,2),DIK,DA
 . S NEXT=$O(@ORMSG@(LAST)) I NEXT,$E(@ORMSG@(NEXT),1,3)="ZSY" D
 . . K DA,DIC S DA(1)=ORDIFN,DIC="^ORD(101.43,"_DA(1)_",2,"
 . . S DIC(0)="L",ZSY=LAST ;,DIC("P")=$P(^DD(101.43,1,0),U,2)
 . . F  S ZSY=$O(@ORMSG@(+ZSY)) Q:ZSY'>0  Q:$E(@ORMSG@(ZSY),1,3)'="ZSY"  D
 . . . S X=$P(@ORMSG@(ZSY),"|",3),LAST=ZSY
 . . . K DD,DO D:$L(X) FILE^DICN
NTE . K ^ORD(101.43,ORDIFN,8) ; replace text
 . S NEXT=$O(@ORMSG@(LAST)) I NEXT,$E(@ORMSG@(NEXT),1,3)="NTE" D
 . . S NTE=LAST,DA=0
 . . F  S NTE=$O(@ORMSG@(NTE)) Q:NTE'>0  Q:$E(@ORMSG@(NTE),1,3)'="NTE"  S DA=DA+1,^ORD(101.43,ORDIFN,8,DA,0)=$P(@ORMSG@(NTE),"|",4) I $O(@ORMSG@(NTE,0)) D
 . . . S I=0 F  S I=$O(@ORMSG@(NTE,I)) Q:I'>0  S DA=DA+1,^ORD(101.43,ORDIFN,8,DA,0)=@ORMSG@(NTE,I)
 . . S ^ORD(101.43,ORDIFN,8,0)="^^"_DA_U_DA_U_DT_U
 . I '$D(^TMP($J,"OR OI NEW",ORDIFN)) M ^TMP($J,"OR OI AFTER",ORDIFN)=^ORD(101.43,ORDIFN)
 Q
 ;
NMSP(NAME) ; -- returns namespace for package
 I NAME="RADIOLOGY" Q "RA"
 I NAME="IMAGING" Q "RA"
 I NAME="LABORATORY" Q "LR"
 I NAME="DIETETICS" Q "FH"
 I NAME="PHARMACY" Q "PS"
 I NAME="CONSULTS" Q "CS"
 I NAME="PROCEDURES" Q "CS"
 Q ""
 ;
CREATE(X) ; -- Create new item in #101.43
 Q:'$L($G(X)) 0 N HDR,LAST,TOTAL,I
 L +^ORD(101.43,0):1 Q:'$T 0
 S HDR=$G(^ORD(101.43,0)) Q:HDR="" 0
 S LAST=$P(HDR,U,3),TOTAL=$P(HDR,U,4)
 F I=(LAST+1):1 Q:'$D(^ORD(101.43,I,0))
 S ^ORD(101.43,I,0)=X,X=$E(X,1,30),^ORD(101.43,"B",$$UP^XLFSTR(X),I)=""
 S $P(^ORD(101.43,0),U,3,4)=I_U_(TOTAL+1)
 L -^ORD(101.43,0)
 Q I
 ;
FH ; -- Dietetics
 S X=$P(ZPKG,"|",2),ORFLD(111.1)=$S(X="":"@",1:X)
 S X=$P(ZPKG,"|",3),ORFLD(111.2)=$S(X="":"@",1:X)
 S X=$P(ZPKG,"|",5),ORFLD(111.3)=$S(X="":"@",1:X)
 F NUM=111.1,111.2,111.3 D VAL^DIE(101.43,ORFIEN,NUM,"F",ORFLD(NUM),.ORY,"ORFDA")
 K ^ORD(101.43,ORDIFN,8) S X=$P(ZPKG,"|",4)
 I $L(X) S ^ORD(101.43,ORDIFN,8,0)="^^1^1^"_DT_U,^(1,0)=X
 Q
 ;
LR ; -- Laboratory
 S X=$P(ZPKG,"|",2),ORFLD(60.1)=$S(X="":"@",1:X)
 S X=$P(ZPKG,"|",3),ORFLD(60.2)=$S(X="":"@",1:X)
 ;S X=$P(ZPKG,"|",4),ORFLD(60.3)=$S(X="":"@",1:X)
 S X=$P(ZPKG,"|",5),ORFLD(60.6)=$S(X="":"@",1:X)
 S X=$P(ZPKG,"|",6),ORFLD(60.4)=$S(X="":"@",1:X)
 S X=$P(ZPKG,"|",7),ORFLD(60.5)=$S(X="":"@",1:X)
 S X=$P(ZPKG,"|",8),ORFLD(6)=$S(X="":"@",1:X)
 S X=$P(ZPKG,"|",9),ORFLD(60.7)=$S(X="":"@",1:X)
 F NUM=6,60.1,60.2,60.4,60.5,60.6,60.7 D VAL^DIE(101.43,ORFIEN,NUM,"F",ORFLD(NUM),.ORY,"ORFDA")
 Q
 ;
PS ; -- Pharmacy
 N ROUTE
 S X=$P(ZPKG,"|",2)
 ;S ORFDA(101.43,ORFIEN,50.1)=$S(X'["I":0,$L($P($P(ORDITEM,U,5),"~",3)):2,1:1)
 S ORFDA(101.43,ORFIEN,50.1)=$S(X["V":2,X["I":1,1:0) ;inpt or iv med
 S ORFDA(101.43,ORFIEN,50.2)=(X["O") ;outpt med
 S ORFDA(101.43,ORFIEN,50.3)=(X["B") ;fluid base/soln
 S ORFDA(101.43,ORFIEN,50.4)=(X["A") ;fluid additive
 S ORFDA(101.43,ORFIEN,50.5)=(X["S") ;supply item
 S ORFDA(101.43,ORFIEN,50.7)=(X["N") ;non-VA med
 S X=$P(ZPKG,"|",3),ORFDA(101.43,ORFIEN,50.6)=$S(X:1,1:0)
 ;Check for default med route
 ;S ROUTE=$$MEDROUTE
 ;I ROUTE>0 S ORFDA(101.43,ORFIEN,50.8)=ROUTE
 Q
 ;
MEDROUTE() ;
 N CNT,ROUTE
 S CNT=0,ROUTE=0
 F  S CNT=$O(@ORMSG@(CNT)) Q:CNT'>0  D
 .I $P($G(@ORMSG@(CNT)),"|")'="ZPB" Q
 .S ROUTE=+$P($G(@ORMSG@(CNT)),"|",4)
 Q ROUTE
 ;
RA ; -- Radiology/Nuc Medicine
 S X=$P(ZPKG,"|",4),ORFLD(6)=$S(X="":"@",1:X)
 S X=$P(ZPKG,"|",5),ORFLD(71.1)=$S(X="":"@",1:X)
 S X=$P(ZPKG,"|",7),ORFLD(71.2)=$S(X="":"@",1:X)
 S X=$P(ZPKG,"|",2),ORFLD(71.3)=$S(X="":"@",1:X)
 S ORFLD(71.4)=$S($P(ZPKG,"|",6)="Y":1,1:0)
 S ORFLD(7)=$S($P(ZPKG,"|",3)="Y":2,1:1)
 F NUM=6,7,71.1,71.2,71.3,71.4 D VAL^DIE(101.43,ORFIEN,NUM,"F",ORFLD(NUM),.ORY,"ORFDA")
 Q
 ;
CS ; -- Consults/Requests
 S X=$P(ZPKG,"|",2),ORFLD(123.1)=$S(X="":"@",1:X)
 D VAL^DIE(101.43,ORFIEN,123.1,"F",ORFLD(123.1),.ORY,"ORFDA")
 Q
