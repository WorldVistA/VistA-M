XMAH ;ISC-SF/GMB-List message responses API ;07/17/2003  13:04
 ;;8.0;MailMan;**20**;Jun 28, 2002
 ; Was (WASH ISC)/CAP
 ;
 ; Entry points (DBIA 1040):
 ; ENT8   List responses of a message
 ;
ENT8 ; List message responses
 ; Needs:
 ; XMZ   Message number
 N XMV
 D INITAPI^XMVVITAE
 D HELPRESP^XMJMP1(XMZ,+$P($G(^XMB(3.9,XMZ,3,0)),U,4))
 Q
