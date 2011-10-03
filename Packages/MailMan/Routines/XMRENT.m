XMRENT ;ISC-SF/GMB-Msg Network Header Info API ;04/19/2002  13:17
 ;;8.0;MailMan;;Jun 28, 2002
 ; Was (WASH ISC)/CMW
 ;
 ; Entry points (DBIA 1143):
 ; $$NET  Get message information.
 ;
 ;Extrinsic Function for API call to parse network header
 ;Parameter #1=Message #
 ;
 ;Output=STRING
 ; Message-date ^ Encryption-code ^ Returned addr of sender ^ Message ID
 ; ^ Sender ^ Message subject ^ Message ID of In-reply-to ^ Message Type
 ;
NET(XMZ) ;
 Q:'$D(^XMB(3.9,XMZ,0)) ""
 N XMDATE,XMENCR,XMFROM,XMREMID,XMSEND,XMSUBJ,XMZO,XMFIRST
 S XMFIRST=$O(^XMB(3.9,XMZ,2,0))
 I XMFIRST,XMFIRST<1 D
 . D NETMAIL(XMZ,.XMREMID,.XMSUBJ,.XMFROM,.XMDATE,.XMSEND,.XMENCR,.XMZO)
 E  D
 . D LOCMAIL(XMZ,.XMREMID,.XMSUBJ,.XMFROM,.XMDATE,.XMSEND,.XMENCR,.XMZO)
 Q $G(XMDATE)_U_$G(XMENCR)_U_$G(XMFROM)_U_$G(XMREMID)_U_$G(XMSEND)_U_$G(XMSUBJ)_U_$G(XMZO)_U_$P($G(^XMB(3.9,XMZ,0)),U,7)
LOCMAIL(XMZ,XMREMID,XMSUBJ,XMFROM,XMDATE,XMSEND,XMENCR,XMZO) ; Get data for Locally originated message
 N XMZREC,Y
 S XMZREC=^XMB(3.9,XMZ,0)
 S Y=$P(XMZREC,U,3),%DT="S" D DD^%DT S XMDATE=Y
 S:$P(XMZREC,U,8) XMZO=^XMB("NETNAME")_"@"_$P(XMZREC,U,8)
 S XMSEND=$S($P(XMZREC,U,4)="":"",1:$$NAME^XMXUTIL($P(XMZREC,U,4)))
 S XMENCR=$P(XMZREC,U,10)
 S XMFROM=$$NAME^XMXUTIL($P(XMZREC,U,2))
 S XMSUBJ=$$SUBJ^XMXUTIL2(XMZREC)
 S XMREMID=$$NETID^XMS3(XMZ)
 Q
NETMAIL(XMZ,XMREMID,XMSUBJ,XMFROM,XMDATE,XMSEND,XMENCR,XMZO) ; Get data for Message that originated from another domain
 D PARSE^XMR3(XMZ,.XMREMID,.XMSUBJ,.XMFROM,.XMDATE,.XMSEND,.XMENCR,.XMZO)
 S:$G(XMSUBJ)="" XMSUBJ=" "
 S XMFROM="<"_$$REMADDR^XMXADDR3(XMFROM)_">"
 S:XMREMID[".VA.GOV" XMFROM=$TR($P(XMFROM,"@"),"._+",", .")_"@"_$P(XMFROM,"@",2)
 Q
