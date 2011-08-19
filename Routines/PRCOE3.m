PRCOE3 ;WISC/DJM-IFCAP SEGMENTS HE,MI,CO ;6/18/97  16:29
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
HE(VAR1,VAR2) ;PO HEADER INFORMATION SEGMENT
 ; uses PRCHPC variable to determine if document is a purchase card
 ; PRCHPC should not exist & should not be used in non-Purchase Card options
 ;
 ; VAR1 = string of up to 4 pieces -- (last 3 pieces are optional)
 ;        ('^' piece 1) ==>   ien to file 442 
 ;        ('^' piece 2) ==>   amendment flag (1 for PHM, 2 for PHA)
 ;        ('^' piece 3) ==>   amendment number
 ;        ('^' piece 4) ==>   442 ien of amended order if PO number
 ;                            was changed
 ;
 ; VAR2 is used to pass error conditions to the calling routine
 ;
 N A,A1,AFLG,ANO,B,DA,DD,NM,P,PHN,PM,PNM,PO,POD,PPM,RFQ,SC,MOP,X,Y
 S PO=$P(VAR1,"^",1)
 S A=$G(^PRC(442,PO,0))
 S A1=$G(^PRC(442,PO,1))
 I $G(^PRC(442,PO,12))="" S VAR2="NP12" Q  ; exit if no info in node 12
 ;
 S X=$P(A1,U,15)
 I X="" S VAR2="NPOD" Q  ; exit if no PO Date
 D JD^PRCFDLN ; puts julian date for X in Y
 S POD=$E(X,1,3)+1700_$E(Y,1,3)
 ;
 S X=$P(A,U,10)
 I X="" S VAR2="NDD" Q  ; exit if no delivery date
 D JD^PRCFDLN ; Puts julian date for X in Y
 S DD=$E(X,1,3)+1700_$E(Y,1,3)
 ;
 S AFLG=$P(VAR1,"^",2) I AFLG="" S AFLG=0
 S DA=PO
 I AFLG=2 S DA=$P(VAR1,"^",4) ; use old PO's ien if PO number was changed
 ;
 I 'AFLG S P=$P(A1,U,10)
 I AFLG D
 . S ANO=$P(VAR1,"^",3) ; amendment number
 . S P=$P(^PRC(442,DA,6,ANO,1),"^",1)
 I P="" S VAR2="NPPM" Q  ; exit if no PA/PPM (or Authorized buyer)
 ;
 S PHN=$P($G(^VA(200,P,.13)),"^",5)
 I '$G(PRCHPC) D  Q:PHN=""
 . I PHN="" S VAR2="NPHN" Q  ;exit if no commercial phone# for PA/PPM
 . S PHN=$P(PHN,U)
 . I PHN="" S VAR2="NPH" Q  ; exit (but when would there be an '^'???)
 ;
 I 'AFLG S PPM=$E("ES/"_$$DECODE^PRCHES5(DA),1,30)
 I AFLG S PPM=$E("ES/"_$$DECODE^PRCHES6(DA,ANO),1,30)
 I PPM="ES/" S VAR2="ESBD" Q  ; exit if no name found
 ;
 S PO=$P(VAR1,"^",1)
 S MOP=$P(A,U,2) ; method of processing
 S MOP=$S(MOP=1:"A",MOP=2:"B",MOP=3:"C",MOP=4:"D",MOP=7:"E",MOP=8:"F",MOP=9:"G",MOP=21:"H",MOP=22:"I",MOP=23:"J",MOP=24:"K",MOP=25:"L",MOP=26:"M",1:"")
 S:MOP="" MOP="A"
 ;
 S SC=$P(A1,U,7) ; source code
 S:SC>0 SC=$P($G(^PRCD(420.8,SC,0)),U)
 S RFQ=$P($G(^PRC(442,PO,21)),U,8)
 S PM=0
 S PM=$O(^PRC(442,PO,14,PM)) ; purchase method
 D:PM>0
 .  S PM=$P($G(^PRC(442,PO,14,PM,0)),U) Q:PM'>0
 .  S PM=$P($G(^PRC(442.4,PM,0)),U)
 .  Q
 ;
 S B="HE^^"_POD_"^"_SC_"^"_DD_"^^^"_PPM_"^"_PHN_"^"_PM_"^"_MOP_"^^0^^^^"_RFQ_"^1^|"
 S ^TMP($J,"STRING",1)=B
 Q
 ;
MI(VAR1,VAR2) ;MISCELLANEOUS INFORMATION SEGMENT
 N B,F1,F2,I2,ITEM,M0,M1,M12,M23,PR
 S M0=$G(^PRC(442,VAR1,0))
 S M1=$G(^PRC(442,VAR1,1))
 S M12=$G(^PRC(442,VAR1,12))
 S M23=$G(^PRC(442,VAR1,23))
 S B="MI^^"_$P(M12,U,7)_"^" ; FIELDS 1, 2, 3
 I $P(M23,U,11)="P" S F1="" G MI1
 S F1=$P(M1,U,7)
 S:F1="" VAR2="NSC"
 Q:F1=""
 S F1=$S(F1=9:"B","2,3,5,8"[F1:"P",1:"D")
MI1 S B=B_F1_"^^^" ; FIELDS 4, 5, 6
 S PR=$P(M1,U,8)
 I $P(M0,U,19)=2,PR="" S PR="N/A"
 S:PR="" VAR2="NOPR"
 Q:PR=""
 S B=B_PR_"^^^^|" ; FIELDS 7, 8, 9, 10, 11
 S ^TMP($J,"STRING",5)=B
 Q
 ;
CO(VAR1,VAR2,TOTAL) ;COMMENT INFORMATION SEGMENT
 N B,TOSH
 S TOSH=$P($G(^PRC(442,VAR1,12)),U,14)
 Q:TOSH=""
 S TOSH=$E($P(^PRC(443.4,TOSH,0),U,3),1,59)
 S B="CO^1^"_TOSH_"^|"
 S ^TMP($J,"STRING",TOTAL)=B
 S TOTAL=TOTAL+1
 S B=^TMP($J,"STRING",1)
 S $P(B,U,13)=$P(B,U,13)+1
 S ^TMP($J,"STRING",1)=B
 Q
