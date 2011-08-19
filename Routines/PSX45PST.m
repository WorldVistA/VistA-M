PSX45PST ;BIR/PW-REMOVE 552.4 RX INDEX CROSREFFERENCE "E" ;01/02/03
 ;;2.0;CMOP;**45**;11 Apr 97
 K ^PSX(552.4,"E")
 Q
PRE ;delete field RX INDEX including 'E' xref and then reinstall it without the 'E' xref.
 Q:'$D(^PSX(552.4))
 K DA,DIK S DIK="^DD(552.41,",DA=40,DA(1)=552.41 D ^DIK
 Q
