RMPRHL7 ;HINES-CIOFO/HNC - HL7 formatting information;3/13/00
 ;;3.0;PROSTHETICS;**45,54**;Feb 09, 1996
 ;
 ; HNC-10/13/00; Make change to Date/Time for HL7 update.
 ;              call $$HL7TFM^XLFDT(DATE)
 ;              and $$FMTHL7^XLFDT(DATE) per David Naber 10/00
 ;              patch 53 and OR*3*97
 Q
MSH(X) ;Format MSH segment of HL-7 message.
 ;FROM=RMPR PROSTHETICS - sending
 N X
 S X="MSH|^~\&|PROSTHETICS|"_$S(+$G(DUZ(2)):DUZ(2),1:$$SITE^VASITE())_"|||||ORM"
 Q X
 ;
 ;
 Q
HL7DT(DATE) ;Convert Fileman Date to HL-7 Date
 ;
 N X
 S X=$$FMTHL7^XLFDT(DATE)
 Q X
 ;
FMDATE(DATE) ;Convert HL-7 formatted date to a Fileman formatted date
 ;
 ;
 N X
 S X=$$HL7TFM^XLFDT(DATE)
 Q X
 ;
 ;END
