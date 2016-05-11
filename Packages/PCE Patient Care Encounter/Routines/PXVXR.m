PXVXR ;BIR/ADM - CROSS REFERENCE AND OTHER LOGIC ;11/06/2015
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**210**;Aug 12, 1996;Build 21
 ;
 Q
EXP ; check for expiration date in the past
 N PXVX,PXVDT,Y
 S PXVDT=X I PXVDT<DT D  Q
 .D EN^DDIOL(">>> The date entered is a past date. <<<","","!!?4") S PXVX=$C(7) D EN^DDIOL(PXVX,"","!")
 .K DIR S DIR("A")=" Are you sure you have entered the correct date",DIR(0)="Y",DIR("B")="NO" D ^DIR K DIR
 .I $D(DTOUT)!$D(DUOUT)!'Y K X Q
 .S X=PXVDT
 Q
INUSE ; input check on LOT NUMBER field (#.01)
 N PXV,PXVIM,PXVLN,PXVMAN,PXVX
 I $D(^AUPNVIMM("LN",DA)) D  Q:'$D(X)
 .D EN^DDIOL("Lot Number already assigned and cannot be edited.","","!!?4")
 .S PXVX=$C(7) D EN^DDIOL(PXVX,"","!") K X
COMB ; check on LOT NUMBER field (#.01) for uniqueness of Immunization Name, Lot Number and Manufacturer combination
 S PXVLN=X
 S PXV=$G(^AUTTIML(DA,0)),PXVMAN=$P(PXV,"^",2),PXVIM=$P(PXV,"^",4) I PXVMAN=""!(PXVIM="") Q
AUCHK I $D(^AUTTIML("AC",PXVIM,PXVMAN,PXVLN)) D  Q
 .D EN^DDIOL("Immunization Name, Lot Number and Manufacturer combination must be unique.","","!!?4")
 .S PXVX=$C(7) D EN^DDIOL(PXVX,"","!") K X
 Q
COMB1 ; input check on MANUFACTURER field (#.02)
 N PXV,PXVIM,PXVLN,PXVMAN,PXVX
 S PXVMAN=X
 S PXV=$G(^AUTTIML(DA,0)),PXVLN=$P(PXV,"^"),PXVIM=$P(PXV,"^",4) I PXVLN=""!(PXVIM="") Q
 D AUCHK
 Q
COMB2 ; input check on VACCINE field (#.04)
 N PXV,PXVIM,PXVLN,PXVMAN,PXVX
 S PXVIM=X
 S PXV=$G(^AUTTIML(DA,0)),PXVLN=$P(PXV,"^"),PXVMAN=$P(PXV,"^",2) I PXVLN=""!(PXVMAN="") Q
 D AUCHK
 Q
ACT() ; screen immunization with active immunization lot number
 N PXVIMM,PXVVAC
 S PXVIMM=0 D  Q PXVIMM
 .I $D(DA),$D(^AUTTIML("C",$P(^AUPNVIMM(DA,0),U),Y)) S PXVIMM=1 Q
 .I $G(PXCEFIEN),$D(^AUTTIML("C",$P(^AUPNVIMM(PXCEFIEN,0),U),Y)) S PXVIMM=1 Q
 .I $D(PXD),$D(^AUTTIML("C",$P(PXD,"^"),Y)) S PXVIMM=1 Q
 Q
LOT() ;
 N PXVIMM,PXVLN
 S PXVIMM=0 D  Q PXVIMM
 .S PXVLN=0 F  S PXVLN=$O(^AUTTIML("C",Y,PXVLN)) Q:'PXVLN  I $P(^AUTTIML(PXVLN,0),"^",12)>0 S PXVIMM=1 Q
 Q
STOCK ; check for availability of stock in immunization inventory for selected immunization
 ; decrement inventory level if not historical event
 N PXVDA,PXVIEN,PXVIMM,PXVLN,PXVSTOCK,X
 I $$HIST Q
 S PXVDA=$S($G(DA):DA,$G(PXKPIEN):PXKPIEN,$G(PXVNEWIM):PXVNEWIM,1:"") Q:'$G(PXVDA)
 S (PXVLN,PXVSTOCK)=0,PXVIEN=$P(^AUPNVIMM(PXVDA,0),"^")
 I '$O(^AUTTIML("C",PXVIEN,PXVLN)) Q
 F  S PXVLN=$O(^AUTTIML("C",PXVIEN,PXVLN)) Q:'PXVLN  I $P(^AUTTIML(PXVLN,0),"^",12)>0 S PXVSTOCK=1 Q
 I 'PXVSTOCK S PXVIMM=$P(^AUTTIMM(PXVIEN,0),"^") D
 .D EN^DDIOL(">> No stock available for "_PXVIMM_"! <<",,"!!,?2")
 .D ALERT
 S X=$P($G(^AUPNVIMM(PXVDA,12)),"^",7) I $G(X) D DECR
 Q
HIST() ; check if historical encounter
 N PXVIEN,PXVHIST,PXVSIT,PXVSRCE
 S PXVHIST=0
 S PXVIEN=$S($G(DA):DA,$G(PXKPIEN):PXKPIEN,$G(PXVNEWIM):PXVNEWIM,1:"") I 'PXVIEN Q PXVHIST
 S PXVSRCE=$P($G(^AUPNVIMM(PXVIEN,13)),"^")
 I PXVSRCE S PXVHIST=$S(PXVSRCE=$O(^PXV(920.1,"H","00",0)):0,1:1) Q PXVHIST
 S PXVSIT=$P(^AUPNVIMM(PXVIEN,0),"^",3)
 I $P($G(^AUPNVSIT(PXVSIT,0)),"^",7)="E" S PXVHIST=1
 Q PXVHIST
 ;
ALERT ; send alert if no stock available 
 N XQA,XQAMSG,PXVVAR
 S XQA(DUZ)=""
 S XQAMSG="No stock available for "_PXVIMM_"!"
 S PXVVAR=$$SETUP1^XQALERT
 Q
DECR ; set logic for AF x-ref in V IMMUNIZATION file
 ; decrement doses unused in IMMUNIZATION LOT file
 I $$HIST Q
 N PXV
 S PXV=$P($G(^AUTTIML(X,0)),"^",12) I 'PXV Q
 S PXV=PXV-1,$P(^AUTTIML(X,0),"^",12)=PXV
 K PXVNEWIM
 Q
INCR ; kill logic for AF x-ref in V IMMUNIZATION file
 ; increment doses unused in IMMUNIZATION LOT file
 I $$HIST Q
 N PXV
 S PXV=$P($G(^AUTTIML(X,0)),"^",12) I PXV="" Q
 S PXV=PXV+1,$P(^AUTTIML(X,0),"^",12)=PXV
 Q
