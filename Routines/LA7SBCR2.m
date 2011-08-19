LA7SBCR2 ;DALOI/JMC - Shipping Barcode Reader Utility ; 16 Sept 2004
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27,46,64**;Sep 27, 1994
 ;
 Q
 ;
SITE(LA7,LA7PROM,LA7BAR) ; Setup remote site info.
 ; Input:
 ;                  LA7=array to return values
 ;              LA7PROM=prompt to display to user
 ;               LA7BAR=0/1 using barcode reader
 ; Screen: Second piece of bar-code must = SITE
 ; Returns array LA7()
 ;
 ;  If successful ERROR=0
 ;               IDTYPE=source of UID
 ;                  LPC=longitudinal parity check of SM barcode info
 ;               RPSITE=primary sending site ien^name^station number
 ;                RSITE=sending site ien^name^station number
 ;                 SCFG=pointer to shipping configuration (file #62.9)^name
 ;                  SDT=Shipping date/time
 ;                 SMID=shipping manifest id
 ;           
 ;   unsuccessful ERROR=>0^error message
 ;
 N LA7X,X,Y
 ; Initialize array.
 F Y="ERROR","IDTYPE","LPC","RPSITE","RSITE","SCFG","SDT","SMID" S LA7(Y)=""
 S LA7PROM=$G(LA7PROM,"Site")
 I LA7BAR D BAR
 ;
 I 'LA7BAR D
 . N DIR,DIRUT,DTOUT,DUOUT,X,Y
 . S DIR(0)="PO^62.9:EM",DIR("A")="Select Shipping Configuration"
 . S DIR("S")="I $P(^LAHM(62.9,Y,0),U,3)=DUZ(2),$P(^LAHM(62.9,Y,0),U,4)"
 . D ^DIR
 . I Y<1 S LA7("ERROR")=1 Q
 . S LA7("SCFG")=Y
 ;
 I 'LA7("ERROR") D
 . I LA7("SCFG") D GETSITE Q
 . I 'LA7("SCFG") S LA7("ERROR")=3 Q
 ;
 I LA7("ERROR") D
 . S LA7("ERROR")=LA7("ERROR")_"^"_$P($T(ERROR+LA7("ERROR")),";;",2)
 ;
 Q
 ;
 ;
GETSITE ; Retrieve site info from institution file for this shipping configuration.
 ; Set ID type from shipping configuration.
 N LRX,LRY,X,Y
 S Y(0)=$G(^LAHM(62.9,+LA7("SCFG"),0))
 S LA7("IDTYPE")=$P(Y(0),"^",5)
 ;
 ; *** Remove line when other id types supported. ***
 I LA7("IDTYPE")>1 S LA7("ERROR")=4
 ;
 S LRX=$P(Y(0),"^",2)
 S LRY=$$GET1^DIQ(4,LRX_",",.01)
 I LRX,LRY'="" D
 . S LRY(99)=$$RETFACID^LA7VHLU2(LRX,2,1)
 . S LA7("RSITE")=LRX_"^"_LRY_"^"_LRY(99)
 E  S LA7("ERROR")=5
 ;
 S LRX=$P(Y(0),"^",6)
 S LRY=$$GET1^DIQ(4,LRX_",",.01)
 I LRX,LRY'="" D
 . S LRY(99)=$$RETFACID^LA7VHLU2(LRX,2,1)
 . S LA7("RPSITE")=LRX_"^"_LRY_"^"_LRY(99)
 E  S LA7("ERROR")=5
 Q
 ;
 ;
BAR ; Read SM bar code
 ;
 N LA7BCS,Y
 ;
 S Y=$$RD^LA7SBCR(.LA7PROM,1),LA7=""
 I Y=0 S LA7("ERROR")=1 Q
 I Y<1 S LA7("ERROR")=2 Q
 ;
 ; barcode info & longitudinal parity check
 ; original bar code style
 I $E(Y,1,11)="1^STX^SITE^" D
 . S LA7=$P(Y,"STX^SITE^",2)
 . S LA7=$P(LA7,"^ETX",1)
 . S LA7("LPC")=$P(Y,"^ETX",2)
 ; new bar code style
 I $E(Y,1,7)="1^SITE^" D
 . S LA7=$P(Y,"^",3,5)
 . S LA7("LPC")=$P(Y,"^",6)
 . S LA7BCS=1
 ;
 I LA7="" S LA7("ERROR")=2 Q
 ;
 I $P(LA7,"^")'="" D
 . N X,Y,Z
 . S Z=$$FINDSITE^LA7VHLU2($P(LA7,"^"),2,1)
 . I Z="" S LA7("ERROR")=5 Q
 . S (X,Y)=0
 . F  S X=$O(^LAHM(62.9,"C",Z,X)) Q:'X  D  Q:Y
 . . S X(0)=$G(^LAHM(62.9,X,0))
 . . I $P(X(0),"^",3)=DUZ(2),$P(X(0),"^",4) S LA7("SCFG")=X_"^"_$P(X(0),"^"),Y=1
 ;
 ; shipping date/time
 I $P(LA7,"^",2) S LA7("SDT")=$$DT^LA7SBCR($P(LA7,"^",2))
 ;
 ; shipping manifest id
 I $P(LA7,"^",3)'="" S LA7("SMID")=$P(LA7,"^",3)
 ;
 Q
 ;
 ;
ERROR ;; Code/Text of error messages
1 ;;User timeout/abort;;
2 ;;Incorrect barcode format;;
3 ;;No Shipping Configuration identified in file #62.9;;
4 ;;Sender's Specimen ID source not presently supported;;
5 ;;No entry in INSTITUTION file #4;;
