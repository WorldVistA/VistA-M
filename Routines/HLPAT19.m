HLPAT19 ;SFIRMFO/RSD  Pre & Post Install for HL7 patch 19 ;11/20/98  09:54
 ;;1.6;HEALTH LEVEL SEVEN;**19**;JUL 17, 1995
 ;
 ;check that conversion already run
 I @XPDGREF@("POST") D BMES^XPDUTL("Conversion already run!") Q
 ;convert pointer in File 772 to Date/Time
 L +^HL(772),+^HLMA
 S XPDIDCNT=0,XPDIDTOT=+$P(^HL(772,0),U,4)
 N DA2,DA3,DIK,MID,MDT,WORK,X,Y
 S (DA2,WORK)=0
 ;find pointers to file 773 = DA3
 F  S DA2=$O(^HL(772,DA2)) Q:'DA2  S DA3=+$G(^(DA2,0)) D:DA3
 . ;quit if pointer to 773 doesn't exist
 . Q:'$D(^HLMA(DA3,0))
 . S MDT=$P(^HLMA(DA3,0),U),WORK=1
 . D CNV2(DA2)
 . S XPDIDCNT=XPDIDCNT+1 D:'(XPDIDCNT#10) UPDATE^XPDID(XPDIDCNT)
 ;
 ;nothing was converted
 I 'WORK L  Q
 ;remove all remaining entries in 773
 S DA3=0
 F  S DA3=$O(^HLMA(DA3)) Q:DA3=""  K ^HLMA(DA3)
 ;re-index file 773
 S DIK="^HLMA(",DIK(1)=.01 D ENALL^DIK
 L
 Q
CNV2(DA) ;convert .01 field in 772 from pointer to Date/Time
 K ^HL(772,"B",DA3,DA)
 S $P(^HL(772,DA,0),U)=MDT,^HL(772,"B",MDT,DA)=""
 Q
