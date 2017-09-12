SD5371PT ;ALB/SEK - POST-INSTALL FOR PATCH SD*5.3*71 ; 24-OCT-96
 ;;5.3;Scheduling;**71**;AUG 13, 1993
 ;
EN ; This routine will be executed upon installation of the KIDS build.
 ;
 ; This routine will loop through the active clinics ot the
 ; HOSPITAL LOCATION file (#44) and check providers
 ; (DEFAULT PROVIDER field #16 and PROVIDER field #.01 of the PROVIDER
 ; multiple #2600) in the NEW PERSON file (#200).  If these providers
 ; are inactive or active with no active entry in the NEW PERSON
 ; file for PERSON CLASS, a list will be generated for the site.
 ; This PERSON CLASS check is the replacement screen for the
 ; provider key screen on the provider fields.
 ;
 K ^TMP($J)
 N CNT,CNT1,CNT2,CNT3,I,II,NODE,SDDP,SDINACT,SDNAMEC,SDNAMEP
 S CNT=0
 ;
 D BMES^XPDUTL("This will loop through the active clinics of the HOSPITAL LOCATION")
 D MES^XPDUTL("file (#44) and check for inactive providers and for active")
 D MES^XPDUTL("providers with no active entry in the NEW")
 D MES^XPDUTL("PERSON file (#200) for PERSON CLASS.")
 ;
 ;
 ;- get IEN from HOSPITAL LOCATION file using "AC" xref
 S I=0
 F  S I=$O(^SC("AC","C",I)) Q:'I  D
 .S NODE=$G(^SC(I,0)) Q:NODE']""
 .;
 .; check if active clinic
 .S SDINACT=$G(^SC(I,"I"))
 .Q:'$S(SDINACT']"":1,'+$P(SDINACT,"^"):1,DT<+$P(SDINACT,"^"):1,+$P(SDINACT,"^",2):1,1:0)
 .; get DEFAULT PROVIDER 
 .S SDDP=$P(NODE,"^",13) I SDDP D CHECK
 .;
 .; get PROVIDER
 .S II=0 F  S II=$O(^SC(I,"PR",II)) Q:'II  D
 ..S SDDP=+$G(^SC(I,"PR",II,0)) Q:'SDDP  D CHECK
 .Q
 ;
 ; print providers
 D BMES^XPDUTL("You have "_CNT_" providers that are inactive or active with no active")
 D MES^XPDUTL("entry in the NEW PERSON file for PERSON CLASS.  The following")
 D MES^XPDUTL("list contains clinic(s) provider is assigned to:")
 S CNT1=0
 F  S CNT1=$O(^TMP($J,CNT1)) Q:CNT1']""  D
 .S CNT2=0
 .F  S CNT2=$O(^TMP($J,CNT1,CNT2)) Q:'CNT2  D
 ..D MES^XPDUTL("  "_CNT1_"   (IEN="_CNT2_")")
 ..S CNT3=0
 ..F  S CNT3=$O(^TMP($J,CNT1,CNT2,CNT3)) Q:CNT3']""  D
 ...D MES^XPDUTL("         "_CNT3)
 K ^TMP($J)
 Q
 ;
CHECK ; check if provider is active and has an active entry for PERSON CLASS
 Q:$$SCREEN^SDUTL2(SDDP)
 ;
 S SDNAMEP=$P($G(^VA(200,+SDDP,0)),"^")
 S SDNAMEC=$P(NODE,"^")
 I '$D(^TMP($J,SDNAMEP,+SDDP)) D  Q
 .S ^TMP($J,SDNAMEP,SDDP)=""
 .S ^TMP($J,SDNAMEP,SDDP,SDNAMEC)=""
 .S CNT=CNT+1
 I '$D(^TMP($J,SDNAMEP,+SDDP,SDNAMEC)) S ^TMP($J,SDNAMEP,SDDP,SDNAMEC)=""
 Q
