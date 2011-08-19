HLMA3 ;OIFO-O/RJH-API TO LOGICAL LINK FILE ;05/30/08  16:05
 ;;1.6;HEALTH LEVEL SEVEN;**126,142**;Oct 13, 1995;Build 17
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
IEDOMAIN() ;
 ; API for retrieving domain of site's local Interface Engine
 ; from logical link VA-VIE
 ; 
 ; no input
 ; output:
 ; return DNS domain if available, else return null string.
 ;
 N HLTEMP
 ; retrive data from DNS Domain field of file #870
 S HLTEMP("VA-VIE-IEN")=$O(^HLCS(870,"B","VA-VIE",0))
 S HLTEMP("DOMAIN")=$P($G(^HLCS(870,+$G(HLTEMP("VA-VIE-IEN")),0)),"^",8)
 Q HLTEMP("DOMAIN")
 ;
LINKAPI(LINK,DOMAIN,AUTOSTAR) ;
 ; API for updating fields, DNS Domain and Autostart, of logical link
 ; the API may only be applied to production account.
 ; inputs: 
 ; LINK -     1. ien of HL Logical Link file (#870), or 
 ;            2. name (field 'Node'- #.01) of HL Logical Link file
 ;               (#870)
 ; DOMAIN -   data for DNS domain field (field #.08)
 ; AUTOSTAR - data for Autostart field (field #4.5),
 ;            0 for Disabled, 1 for Enabled. 
 ;            Otherwise, data won't be updated
 ;
 ; output could be either of the following:
 ; 1^DOMAIN,AUTOSTART have been updated 
 ; 1^DOMAIN has been updated 
 ; 1^AUTOSTART has been updated 
 ; -1^none has been updated
 ; -1^the api may not be applied to non-production account 
 ;
 N HLTEMP,HLZ
 ;retrieve data from HL Communication Server Parameter file (#869.3)
 ; - Default Processing Id (#.03) 
 ;
 S HLTEMP("PARAM")=$$PARAM^HLCS2
 S HLTEMP("DEFAULT-PROCESSING-ID")=$P(HLTEMP("PARAM"),"^",3)
 ;
 ; quit if this is a non-production account
 Q:HLTEMP("DEFAULT-PROCESSING-ID")'="P" "-1^the api may not be applied to non-production account"
 ;
 ; get input data for link ien or name
 S HLTEMP("IEN")=$G(LINK)
 I 'HLTEMP("IEN")&($L(HLTEMP("IEN"))) S HLTEMP("IEN")=+$O(^HLCS(870,"B",HLTEMP("IEN"),0))
 ;
 ; quit if no ien
 Q:'HLTEMP("IEN") "-1^none has been updated"
 ;
 ; get input data for DNS domain field
 S HLTEMP("DOMAIN")=$G(DOMAIN)
 ;
 ; get IP address for the domain
 I $L(HLTEMP("DOMAIN")) S HLTEMP("IP")=$$ADDRESS^XLFNSLK(HLTEMP("DOMAIN"))
 ;
 ; invalid domain, set it to null
 I $L(HLTEMP("DOMAIN")),'$G(HLTEMP("IP")) S HLTEMP("DOMAIN")=""
 ;
 ; get input data for Autostart field
 S HLTEMP("AUTOSTART")=$G(AUTOSTAR)
 ;
 ; quit if invalid data for both fields
 Q:($L(HLTEMP("DOMAIN"),".")'>2)&'((HLTEMP("AUTOSTART")="0")!(HLTEMP("AUTOSTART")="1")) "-1^none has been updated"
 I $L(HLTEMP("DOMAIN"),".")>2 D
 . S HLZ(870,HLTEMP("IEN")_",",.08)=HLTEMP("DOMAIN")
 I (HLTEMP("AUTOSTART")="0")!(HLTEMP("AUTOSTART")="1") D
 . S HLZ(870,HLTEMP("IEN")_",",4.5)=HLTEMP("AUTOSTART")
 D FILE^DIE("S","HLZ","HLZ")
 ;
 ; both fields are updated
 Q:$D(HLZ(870,HLTEMP("IEN")_",",.08))&($D(HLZ(870,HLTEMP("IEN")_",",4.5))) "1^DOMAIN,AUTOSTART have been updated"
 ;
 ; only update DNS Domain field
 Q:$D(HLZ(870,HLTEMP("IEN")_",",.08)) "1^DOMAIN has been updated"
 ;
 ; only update Autostart field
 Q:$D(HLZ(870,HLTEMP("IEN")_",",4.5)) "1^AUTOSTART has been updated"
 ;
IP(DA,HLIP) ;
 ; 1. API to update field TCP/IP Address, #870,400.01.
 ; 2. called from input transform of #870,.08 DNS Domain to update
 ;    field TCP/IP Address, #870,400.01.
 ;
 ; input:
 ; DA -   1. ien of HL Logical Link file (#870), or 
 ;        2. name (field 'Node'- #.01) of HL Logical Link file (#870)
 ; HLIP - IP addresses
 ; 
 ; output:
 ; return IP address updated to the field if valid,
 ; else return null string.
 ;
 N HLZ,HLI,HLTEMP
 ; 
 ; get input data
 S DA=$G(DA)
 I 'DA&($L(DA)) S DA=+$O(^HLCS(870,"B",DA,0))
 ;
 ; invalid ien
 Q:'DA ""
 ;
 ; invalid ip
 Q:('HLIP) ""
 ;
 ; get port number
 S HLTEMP("PORT")=+$P($G(^HLCS(870,DA,400)),"^",2)
 ;
 ; invalid port
 Q:'HLTEMP("PORT") ""
 ;
 S HLTEMP("IP")=""
 S HLTEMP("IP-VALID")=0
 S HLTEMP("IP-COUNT")=$L($G(HLIP),",")
 F HLI=1:1:HLTEMP("IP-COUNT") D  Q:HLTEMP("IP-VALID")
 . S HLTEMP("IP")=$P(HLIP,",",HLI)
 . I '$G(HLTCPLNK("TIMEOUT")) S HLTCPLNK("TIMEOUT")=5
 . D CALL^%ZISTCP(HLTEMP("IP"),HLTEMP("PORT"),HLTCPLNK("TIMEOUT"))
 . I 'POP D
 .. D CLOSE^%ZISTCP
 .. S HLTEMP("IP-VALID")=HLTEMP("IP")
 ;
 ; invalid ip, return null
 Q:'HLTEMP("IP-VALID") ""
 ;
 ; valid data to update the field
 S HLZ(870,DA_",",400.01)=HLTEMP("IP-VALID")
 D FILE^DIE("E","HLZ","HLZ")
 ;
 ; return the valid ip
 Q HLTEMP("IP-VALID")
 ;
FACILITY(LINK,DELIMITR) ;
 ; API for retrieving the station number and domain fields of logical
 ; link (file #870) and to be usd for populating in field MSH-6 
 ; (receiving facility) of message header.
 ;
 ; output format: institution number<delimiter>domain<delimiter>DNS
 ;
 ; inputs:
 ; LINK -       1. ien of HL Logical Link file (#870), or
 ;              2. name (field 'Node'- #.01) of HL Logical Link file
 ;               (#870)
 ; DELIMITR -  such as "~", "^", etc.
 ;
 ; output:
 ;        1.  institution number<delimiter>domain<delimiter>DNS
 ;        2.  <null> if input data is invalid
 ;
 ; note: if the domain retrieved from DNS domain field with "HL7."
 ;       or "MPI." prefixed at the beginning of the domain, the
 ;       prifixed "HL7." or "MPI." will be removed, in order to
 ;       meet the current implementation of Vista HL7.  Current
 ;       VISTA HL7 domain is retrieved from MailMan domain field,
 ;       the "HL7." or "MPI." is not prefixed at the beginning of
 ;       the domain when it is populated in field MSH-6 (receiving
 ;       facility) of message header. 
 ;
 N HLLINK,HLCINS,HLCDOM
 ;
 ; get input data for link ien or name
 S HLLINK=$G(LINK)
 I 'HLLINK,HLLINK]"" D
 .S HLLINK=$O(^HLCS(870,"B",HLLINK,0))
 ;
 ; quit if no ien
 Q:'HLLINK ""
 ;
 ; get DELIMITR
 S DELIMITR=$G(DELIMITR)
 ;
 ; quit if invalid DELIMITR
 Q:$L(DELIMITR)'=1 ""
 ;
 ; retrive data from DNS Domain field of file #870
 S HLCDOM("DNS")=$P($G(^HLCS(870,+HLLINK,0)),"^",8)
 ;
 ; remove the first piece if the first piece is "HL7" or "MPI"
 I ($P(HLCDOM("DNS"),".")="HL7")!($P(HLCDOM("DNS"),".")="MPI") D
 . S HLCDOM("DNS")=$P(HLCDOM("DNS"),".",2,99)
 ;
 S (HLCINS,HLCDOM)=""
 S HLCINS=$P(^HLCS(870,HLLINK,0),U,2)
 S HLCDOM=$P(^HLCS(870,HLLINK,0),U,7)
 ;
 ; quit if no data in institution and domain fields
 Q:('HLCINS)&('HLCDOM)&('$L(HLCDOM("DNS"))) ""
 ;
 ; initialize result
 S HLLINK("RESULT")=""
 ;
 ; if instition ien exists
 I HLCINS D
 . S HLCINS=$P($G(^DIC(4,HLCINS,99)),U)
 . ;
 . ; if valid station number exists
 . I HLCINS D
 .. ; set station number to the first piece of the result
 .. S HLLINK("RESULT")=HLCINS
 ;
 ; if MailMan domain ien exists
 I HLCDOM D
 . ;get MailMan domain name
 . S HLCDOM=$P(^DIC(4.2,HLCDOM,0),U)
 ;
 ; DNS domain overides MailMan domain
 I ($L(HLCDOM("DNS"),".")>2) D
 . S HLCDOM=HLCDOM("DNS")
 ;
 ; set third piece as "DNS" if domain is valid
 I ($L(HLCDOM,".")>2) D
 . ; set domain to the 2nd and 3rd pieces of the result
 . S HLLINK("RESULT")=HLLINK("RESULT")_DELIMITR_HLCDOM_DELIMITR_"DNS"
 Q HLLINK("RESULT")
 ;
VIEDOMNM() ;
 ; API for generating the domain of site's local Interface Engine
 ; if it could be generated based on the VISN, Station number, and
 ; the site's multi-listener, named beginning with "VA".  It returns
 ; null string if this API is executed in 'test' account.
 ;
 ; The real DNS Domain of the VIE server should be the one registered
 ; in the DNS service.
 ; The Domain gernerated by this API should not be used if it is not
 ; the same one gegistered in DNS.
 ; 
 ; no input
 ; output:
 ; return DNS domain if available, else return null string.
 ;
 ;retrieve data from HL Communication Server Parameter file (#869.3)
 ; - Default Processing Id (#.03) 
 ; - Institution (#.04)
 ;
 N HLPARAM
 N HLSITE,INSIEN,NODEIEN,FLAG
 ;
 S HLPARAM=$$PARAM^HLCS2
 S HLSITE("DEFAULT-PROCESSING-ID")=$P(HLPARAM,"^",3)
 ;
 ; ien of "Institution" (#4) file
 S INSIEN=$P(HLPARAM,"^",4)
 ;
 ; if this is a production accout and found the ien in the
 ; "Institution" file
 I HLSITE("DEFAULT-PROCESSING-ID")="P",INSIEN D
 . S FLAG=0
 . S NODEIEN=0
 . F  D  Q:('NODEIEN)!(FLAG=1)
 .. ;
 .. ; find the node ien of file #870
 .. S NODEIEN=$O(^HLCS(870,"C",INSIEN,NODEIEN))
 .. Q:'NODEIEN
 .. ;
 .. ; check if multi-listener
 .. Q:'$D(^HLCS(870,"E","M",NODEIEN))
 .. ;
 .. ; get node name
 .. S HLSITE("NODE")=$P(^HLCS(870,NODEIEN,0),"^")
 .. ;
 .. ; check first 2 characters of node name
 .. Q:$E(HLSITE("NODE"),1,2)'["VA"
 .. ;
 .. ; chech the port number if it is 5000
 .. Q:$P(^HLCS(870,NODEIEN,400),"^",2)'=5000
 .. ;
 .. S FLAG=1
 . ;
 . Q:'FLAG
 . ;
 . ; get station number
 . S HLSITE("STATION")=$P($$NNT^XUAF4(INSIEN),"^",2)
 . ;
 . Q:'HLSITE("STATION")
 . ;
 . ; find the VISN number
 . D PARENT^XUAF4("HLSITE",HLSITE("STATION"),"VISN")
 . S HLSITE("VISN-IEN")=$O(HLSITE("P",0))
 . Q:'HLSITE("VISN-IEN")
 . ;
 . S HLSITE("VISN-NAME")=$G(HLSITE("P",+HLSITE("VISN-IEN")))
 . S HLSITE("VISN-NUMBER")=+$P(HLSITE("VISN-NAME")," ",2)
 . Q:'HLSITE("VISN-NUMBER")
 . ;
 . I $L(HLSITE("VISN-NUMBER"))=1 D
 .. S HLSITE("VISN-NUMBER")="0"_HLSITE("VISN-NUMBER")
 . S HLSITE("DOMAIN")="VHA"_$E(HLSITE("NODE"),3,5)_"VIEV1.V"_HLSITE("VISN-NUMBER")_".MED.VA.GOV"
 ;
 Q $G(HLSITE("DOMAIN"))
 ;
