HLPAT122 ;OIFO-OAKLAND/RJH - HL7 PATCH 122 PRE-INIT ;12/14/2007  13:18
 ;;1.6;HEALTH LEVEL SEVEN;**122**;Oct 13, 1995;Build 14
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
PRE ;
 ; remove HL7 Proxy user, "HLSEVEN,APPLICATION PROXY" : TEST v2
 ;
 ; create application proxy users for listeners and incoming filer
 ; N HLTEMP
 ; S HLTEMP=$$CREATE^XUSAP("HLSEVEN,APPLICATION PROXY","#")
 ;
 ; for Patch HL*1.6*122 TEST v5: remove the code, which is used to
 ; delete the entry, "HLSEVEN,APPLICATION PROXY" in file #200, the
 ; deletion has caused the problem to the IB at the testing sites.
 ; N DIK,DA
 ;
 ; S DIK="^VA(200,"
 ; S DA=$O(^VA(200,"B","HLSEVEN,APPLICATION PROXY",0))
 ; I DA D ^DIK
 Q
POST ;
 D POST1
 D POST2
 Q
 ;
POST1 ;
 ; insert data for multiple fields: #8, #9, #10, #11, and #12.
 N DATA,DA
 ;
 S DA=$O(^HLCS(869.3,0))
 Q:'DA
 Q:'$D(^DD(869.3,70))
 Q:'$D(^DD(869.3,80))
 Q:'$D(^DD(869.3,90))
 Q:'$D(^DD(869.3,91))
 Q:'$D(^DD(869.3,92))
 Q:'$D(^DD(869.3,93))
 S DATA(1,8,0)="^869.35^1^1"
 S DATA(1,8,1,0)="DOMAIN.EXT"
 ;
 S DATA(1,9,0)="^869.36^4^4"
 S DATA(1,9,1,0)="8090, 5561"
 S DATA(1,9,2,0)="9059, 9060, 27315, 27316"
 S DATA(1,9,3,0)="7010, 1583"
 S DATA(1,9,4,0)="8080"
 ;
 S DATA(1,10,0)="^869.391^3^3"
 S DATA(1,10,1,0)="VAHDR, VAFHIE, VA-VIE"
 S DATA(1,10,2,0)="VHAAAC, VAHTH"
 S DATA(1,10,3,0)="VDEF"
 ;
 S DATA(1,11,0)="^869.392^2^2"
 S DATA(1,11,1,0)="127.0.0.1"
 S DATA(1,11,2,0)="127.0.0.1, 127.0.0.1, 127.0.0.1, 127.0.0.1"
 ;
 S DATA(1,12,0)="^869.393^1^1"
 S DATA(1,12,1,0)="HDR.DOMAIN.EXT, FHIE.DOMAIN.EXT"
 ;
 M ^HLCS(869.3,DA)=DATA(1)
 ; re-index
 S DIK="^HLCS(869.3,"
 D IX^DIK
 ;
 ; kill the original "C" x-ref in file #773 and #772
 K ^DD(773,2,1,1)
 K ^DD(772,6,1,1)
 Q
 ;
POST2 ;
 ; clear and set the counter of multi-listener, with port not equal to 5500,
 ; to "0 server"
 N HLDP,HLIEN
 S HLDP=0
 F  S HLDP=$O(^HLCS(870,"E","M",HLDP)) Q:'HLDP  D
 . ; if port number = 5500 quit
 . I $P(^HLCS(870,HLDP,400),"^",2)=5500 Q
 . D CLRMCNTR^HLCSTCP4
 . S HLIEN=HLDP
 . F X="IN","OUT" D CLRQUET^HLUTIL2(X)
 Q
 ;
