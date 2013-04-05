RAIPST ;HIRMFO/GJC- Post-init Driver ;12/22/97  08:32
VERSION ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;
 N RACHK
 S RACHK=$$NEWCP^XPDUTL("POST1","EN1^RAIPST1")
 ;         Install signon-alert into XU Menu
 ;
 S RACHK=$$NEWCP^XPDUTL("POST2","EN2^RAIPST1")
 ;         Delete obsolete *CREDIT CLINIC STOP data dictionary
 ;         (resides in file 71.1)
 ;
 S RACHK=$$NEWCP^XPDUTL("POST3","EN3^RAIPST1")
 ;         Convert free-text pointer data for the Device file
 ;                to pointer data in its true form.
 ;
 S RACHK=$$NEWCP^XPDUTL("POST31")
 ;         Keep track of internal entry numbers in '^RAMIS(71,' when we
 ;         convert free-text pointer data from the Device file to
 ;         pointer data in its true form.
 ;
 S RACHK=$$NEWCP^XPDUTL("POST311")
 ;         Keep track of internal entry numbers in '^RA(79.1,' when we
 ;         convert free-text pointer data from the Device file to
 ;         pointer data in its true form.
 ;
 S RACHK=$$NEWCP^XPDUTL("POST4","EN4^RAIPST1")
 ;        Convert "Allow 'Released/Unverified'" data from the Rad
 ;        Nuc/Med Division '^RA(79,' file to the Imaging Locations
 ;        '^RA(79.1,' file.
 ;
 ;S RACHK=$$NEWCP^XPDUTL("POST6","EN2^RAIPST2")
 ;        Delete incomplete reports from the Rad/Nuc Med Reports file.
 ;        These reports are deleted because they are incomplete, i.e,
 ;        missing Report Text, missing Impression Text, and a report
 ;        Status of 'Draft'.  These reports must not have a pointer
 ;        to the Image (2005) file and must not be purged.
 ;        ('PURGE' node must not exist.)
 ;
 ;
 ;S RACHK=$$NEWCP^XPDUTL("POST61")
 ;        Track the internal entry numbers of the records checked in the
 ;        Rad/Nuc Med Reports file.  Used to check for incomplete Report
 ;        records.
 ;
 S RACHK=$$NEWCP^XPDUTL("POST7","EN3^RAIPST2")
 ;        Update the value of the REPORT RIGHT MARGIN of the IMAGING
 ;        LOCATIONS file.
 ;
 S RACHK=$$NEWCP^XPDUTL("POST8","EN4^RAIPST2")
 ;        Set the 'ASK RADIOPHARMS & DOSAGES?' field (.61) to 'Yes'
 ;        for for the Examinations Status 'EXAMINED' whose Imaging
 ;        Type has the 'RADIOPHARMACEUTICALS USED?' field set to 'Yes'.
 ;
 S RACHK=$$NEWCP^XPDUTL("POST9","EN5^RAIPST2")
 ;        Add 'Mammography' as a new Imaging Type in file 79.2
 ;        Populate the following fields: Operating Conditions
 ;        Abbreviation, Report Cut-Off, Clinical History Cut-Off
 ;        Tracking Time Cut-Off & Order Data Cut-Off
 ;
 S RACHK=$$NEWCP^XPDUTL("POST10","EN1^RAIPST4")
 ;        Add Exam Statuses with an Imaging Type of 'Mammography'.
 ;        Exam Statuses created: Cancelled; Waiting For Exam; Called
 ;        For Exam; Examined; Transcribed and Complete.
 ;
 S RACHK=$$NEWCP^XPDUTL("POSTCLN","CLEANUP^RAIPST2")
 ;        Queue off the RADIOLOGY/NUCLEAR MEDICINE CLEANUP 5.0 build.
 ;        This build removes obsolete data and fields from the database.
 ;
 S RACHK=$$NEWCP^XPDUTL("POST11","EN2^RAIPST4")
 ;        If the HL7 Application Parameter (file 771) 'Radiology'
 ;        does not exist, create it.  Populate the fields with the
 ;        required data.  If the entry exists, change the 'ORU' HL7
 ;        Message processing routine from RAHLO to RAHLBKVR.
 ;        Change the 'QRY' HL7 Message processing routine from RAHLQ
 ;        to RAHLBKVQ.
 ;
 S RACHK=$$NEWCP^XPDUTL("POST12","PRO101^RAIPST5")
 ;        Add the following protocols to file 101 iff they are new
 ;        to the Protocol (101) file: RA CANCEL, RA EVSEND OR,
 ;        RA EXAMINED, RA RECEIVE, RA REG, RA RPT, RA SEND ORM &
 ;        RA SEND ORU
 ;
 Q
