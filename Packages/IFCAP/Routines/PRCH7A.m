PRCH7A ;WISC/PLT-Receiver documents - ORA from ORACLE ; 07/01/98  3:37 PM
V ;;5.1;IFCAP;**20**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
 ;invoked from task manager (see trin^prcosrv2)
 ;convert message to file 440.6
 ;PRCDA=ri of file 423.6 passed
CCR ;Conversion CCR message from FMS MESSAGE SEVER routine PRCOSRV2
 N PRCRI,PRCEDIT,PRCTY,PRCERR,PRCSEQ,PRCEX,A,B
 S PRCRI(423.6)=PRCDA,PRCTY=""
 ;copy ORACLE records to file 440.6
 D ICLOCK^PRC0B("^PRCH(440.8,")
 D COPY(PRCRI(423.6))
 D DCLOCK^PRC0B("^PRCH(440.8,")
 ;
EXIT ;delete ORACLE message in file 423.6
 D KILL^PRCOSRV3(PRCRI(423.6))
 QUIT
 ;
 ;
COPY(PRCA) ;PRCA=ri of file 423.6
 N PRCRI,PRCC,PRCD,PRCE,PRCT,PRCDUZ,PRCTTC,PRCDO,PRCEX,PRCSYS
 N A,B,PRCX,X,Y
 S PRCSYS=1
 S X="NEW",X("DR")="1///NOW;6///T" D ADD^PRC0B1(.X,.Y,"440.8;^PRCH(440.8,") QUIT:Y<1
 S PRCRI(440.8)=+Y
 S PRCC=$O(^PRCF(423.6,PRCA,1,9999)),PRCTTC=0
 D EDIT^PRC0B(.X,"440.8;^PRCH(440.8,;"_PRCRI(440.8),"2///NOW")
 F  S PRCC=$O(^PRCF(423.6,PRCA,1,PRCC)) Q:'PRCC  S PRCD=^(PRCC,0) D:PRCD["~"
 . S PRCT=$P(PRCD,"^")
 . S PRCX=$P(PRCD,"^",22)
 . D:PRCT="CCT"
 .. D EDIT^PRC0B(.X,"440.8;^PRCH(440.8,;"_PRCRI(440.8),".01////"_$P(PRCD,"^",3)_";4////"_$P(PRCD,"^",2))
 .. QUIT
 . D:PRCT="CCR"
 .. S PRCTTC=PRCTTC+1,PRCE="C"_$P(PRCD,"^",2)_$P(PRCD,"^",4),PRCRI(440.6)=$O(^PRCH(440.6,"B",PRCE,""))
 .. I PRCRI(440.6) QUIT:$P(^PRCH(440.6,PRCRI(440.6),0),"^",16)'="N"&($P(^(0),"^",16)]"")
 .. I 'PRCRI(440.6) S X=PRCE D ADD^PRC0B1(.X,.Y,"440.6;^PRCH(440.6,") QUIT:Y<1  S PRCRI(440.6)=+Y
 .. S PRCDUZ="" I $P(PRCD,"^",5)]"" S PRCRI(440.5)=$O(^PRC(440.5,"B",$P(PRCD,"^",5),"")) I PRCRI(440.5) S PRCDUZ=$P(^PRC(440.5,PRCRI(440.5),0),"^",8)
 .. S X="1////"_$P(PRCD,"^",3)_";2////"_$P(PRCD,"^",4)_";3////"_$P(PRCD,"^",5)_";4////"_$P(PRCD,"^",6)_";7////"_$P(PRCD,"^",9)_";9////"_$P(PRCD,"^",11)_";12////"_$P(PRCD,"^",14)_";13////"_$P(PRCD,"^",15)_";14////"_$P(PRCD,"^",21)
 .. S X(1,440.6,1)="20////^S X=PRCX"_";21////"_$P(PRCD,"^",16)_";22////"_$P(PRCD,"^",17)_";23////"_$P(PRCD,"^",18)_";24////"_$P(PRCD,"^",19)_";25////"_$P(PRCD,"^",20)_";16////"_PRCDUZ
 .. D EDIT^PRC0B(.X,"440.6;^PRCH(440.6,;"_PRCRI(440.6),"")
 .. ;edit date fields and status
 .. F A=7,10 S B=$P(PRCD,"^",A),$P(PRCD,"^",A)=$E(B,3,4)_"/"_$E(B,5,6)_"/"_$E(B,1,2)
 .. S B=$P(PRCD,"^",8),$P(PRCD,"^",8)=$E(B,1,2)_"/"_$E(B,3,4)_"/"_$E(B,5,6)
 .. S:$P(PRCD,"^",13)="" $P(PRCD,"^",13)=$P(PRCD,"^",12)
 .. S A="15////N;8///"_$P(PRCD,"^",10)_";6///"_$P(PRCD,"^",8)_";5///"_$P(PRCD,"^",7)_";10///"_$P(PRCD,"^",12)_";11///"_$P(PRCD,"^",13)
 .. D EDIT^PRC0B(.X,"440.6;^PRCH(440.6,;"_PRCRI(440.6),A)
 .. QUIT
 . D:PRCT="CC1"&$G(PRCRI(440.6))
 .. ;I $P(PRCD,"^",9)]"",$P(PRCD,"^",11)]"" QUIT:$TR($P(PRCD,"^",9,11),"^")'=$E(PRCE,2,999)
 .. S A="31////"_$P(PRCD,"^",2)_";32////"_$P(PRCD,"^",3)_";33////"_$P(PRCD,"^",4)_";34////"_$P(PRCD,"^",5)_";35////"_$P(PRCD,"^",6)_";36////"_$TR($P(PRCD,"^",7,8),"^","")
 .. D EDIT^PRC0B(.X,"440.6;^PRCH(440.6,;"_PRCRI(440.6),A)
 .. S PRCRI(440.6)=""
 .. QUIT
 . ;new purchase card data from AFS
 . D:PRCT="CCD"
 .. S PRCTTC=PRCTTC+1,PRCEDIT=0,PRCE=$P(PRCD,"^",2),PRCRI(440.5)=$O(^PRC(440.5,"B",PRCE,""))
 .. S:PRCRI(440.5) PRCEDIT=1
 .. I 'PRCRI(440.5) S X=PRCE D ADD^PRC0B1(.X,.Y,"440.5;^PRC(440.5,") QUIT:Y<1  S PRCRI(440.5)=+Y
 .. S PRCE="51////"_$P(PRCD,"^",3)_$$CCNR^PRCH0A($P(PRCD,"^",3)),$P(PRCE,";",2)="52////"_$P(PRCD,"^",6)
 .. S $P(PRCE,";",3)="53////"_$P(PRCD,"^",7)_$$ST^PRCH0A($P(PRCD,"^",7))_$$STR^PRCH0A($P(PRCD,"^",3),$P(PRCD,"^",7))
 .. S $P(PRCE,";",4)="54////"_$P(PRCD,"^",4)
 .. S $P(PRCE,";",5)="55////"_$P(PRCD,"^",9)_$$FC^PRCH0A($P(PRCD,"^",9))_$$FCR^PRCH0A($P(PRCD,"^",3),$P(PRCD,"^",9))
 .. S $P(PRCE,";",6)="56////"_$P(PRCD,"^",10)_$$ACC^PRCH0A($P(PRCD,"^",10))_$$ACCR^PRCH0A($P(PRCD,"^",3),$P(PRCD,"^",10))
 .. S $P(PRCE,";",7)="57////"_$P(PRCD,"^",11)_$$CC^PRCH0A($P(PRCD,"^",11))_$$CCR^PRCH0A($P(PRCD,"^",3),$P(PRCD,"^",11))
 .. S $P(PRCE(1,440.5,1),";",1)="58////"_$P(PRCD,"^",12)_$$BOC^PRCH0A($P(PRCD,"^",12),$P(PRCD,"^",11))_$$BOCR^PRCH0A($P(PRCD,"^",3),$P(PRCD,"^",12))
 .. S B=$P(PRCD,"^",5),B=$E(B,5,6)_"/"_$E(B,7,8)_"/"_$E(B,1,4)
 .. S A=$$FFVV^PRCH0A(440.5,16,B),B="" S:'$P(PRCD,"^",5)!'A B="*"
 .. S $P(PRCE(1,440.5,1),";",2)="59////"_$P(PRCD,"^",5)_B
 .. S $P(PRCE(1,440.5,1),";",3)="60////"_$P(PRCD,"^",2)_$$CCN^PRCH0A($P(PRCD,"^",2))
 .. S A=$$FFVV^PRCH0A(440.5,4,$P(PRCD,"^",14)),B="" S:$P(PRCD,"^",14)>$P(PRCD,"^",15)!'A!'$P(PRCD,"^",14) B="*" S $P(PRCE(1,440.5,1),";",4)="61////"_$P(PRCD,"^",14)_B
 .. S A=$$FFVV^PRCH0A(440.5,5,$P(PRCD,"^",15)),B="" S:$P(PRCD,"^",15)<$P(PRCD,"^",14)!'A!'$P(PRCD,"^",15) B="*" S $P(PRCE(1,440.5,1),";",5)="62////"_$P(PRCD,"^",15)_B
 ..D EDIT^PRC0B(.PRCE,"440.5;^PRC(440.5,;"_PRCRI(440.5),"") K PRCE
 .. I $P(PRCD,"^",3)]"" S $P(PRCD,"^",3)=$O(^PRC(440.5,"B",$P(PRCD,"^",3),0))
 .. S PRCDO="" I $P(PRCD,"^",3) S PRCDO=$G(^PRC(440.5,$P(PRCD,"^",3),0)) S A="6////"_$P(PRCDO,"^",7)_";7////"_$P(PRCDO,"^",8)_";8////"_$P(PRCDO,"^",9)_";9////"_$P(PRCDO,"^",10)_";10////"_$P(PRCDO,"^",11) D
 ... D EDIT^PRC0B(.X,"440.5;^PRC(440.5,;"_PRCRI(440.5),A)
 ... QUIT
 .. I $P(PRCD,"^",3) S PRCRI=$P(PRCD,"^",3),PRCRI(440.512)=0 F  S PRCRI(440.512)=$O(^PRC(440.5,PRCRI,1,PRCRI(440.512))) QUIT:PRCRI(440.512)<1  S B=$G(^(PRCRI(440.512),0)) D
 ... S X=$P(B,"^") I X,'$D(^PRC(440.5,PRCRI(440.5),1,+X)) D ADD^PRC0B1(.X,.Y,"440.5;^PRC(440.5,;"_PRCRI(440.5)_";12~440.512;^PRC(440.5,"_PRCRI(440.5)_",1,",+X)
 ... QUIT
 .. S A=$G(^PRC(440.5,PRCRI(440.5),0)),B=$G(^(50)),C=$G(^(2)),D=1,PRCE=""
 .. S D=1 I $P(A,"^",8)]"",$P(PRCD,"^",7)]"",$P(PRCDO,"^",2)]"" S $P(PRCE,";",D)="63////"_$P($P(PRCDO,"^",2)," ")_$$UFCP^PRCH0A($P(A,"^",8),$P(PRCD,"^",7),$P(PRCDO,"^",2)),D=D+1
 .. D:PRCE]"" EDIT^PRC0B(.X,"440.5;^PRC(440.5,;"_PRCRI(440.5),PRCE)
 .. S PRCEX="",A=$G(^PRC(440.5,PRCRI(440.5),50)) S:A["*" PRCEX=PRCEX_"*" S:A["#" PRCEX=PRCEX_"#"
 .. D EDIT^PRC0B(.X,"440.5;^PRC(440.5,;"_PRCRI(440.5),"14////"_$S(PRCEX["*":"Y",1:"N")_";70////"_$S(PRCEX]"":"E",1:"P")_";71////"_DT)
 .. I PRCEX'["*" D
 ... S PRCE=$G(^PRC(440.5,PRCRI(440.5),50))
 ... D EDIT^PRC0B(.X,"440.5;^PRC(440.5,;"_PRCRI(440.5),"4////"_$P(PRCE,"^",11))
 ... D EDIT^PRC0B(.X,"440.5;^PRC(440.5,;"_PRCRI(440.5),"5////"_$P(PRCE,"^",12))
 ... S B=$P(PRCE,"^",9) D EDIT^PRC0B(.X,"440.5;^PRC(440.5,;"_PRCRI(440.5),"16///"_$E(B,5,6)_"/"_$E(B,7,8)_"/"_$E(B,1,4))
 ... D EDIT^PRC0B(.X,"440.5;^PRC(440.5,;"_PRCRI(440.5),"2////"_$P(PRCD,"^",11)_";3////"_$P(PRCD,"^",12)_";15////"_$P(PRCD,"^",7)_";1////"_$P(PRCDO,"^",2))
 ... QUIT
 .. QUIT
 . QUIT
 D EDIT^PRC0B(.X,"440.8;^PRCH(440.8,;"_PRCRI(440.8),"3///NOW;5////"_PRCTTC)
 QUIT
