XMA ;ISC-SF/GMB-Read Mail API ;04/17/2002  07:08
 ;;8.0;MailMan;;Jun 28, 2002
 ; Was (WASH ISC)/THM/CAP
 ;
 ; Entry points (DBIA 1284):
 ; REC    Read Mail
 ;
REC ; Read (Manage) Mail
 ; All input variables ignored
 I '$G(DUZ) W !,$C(7),$$EZBLD^DIALOG(38105) Q  ;You do not have a DUZ.
 D EN^XM,MANAGE^XMJBM
 Q
NNEW Q
