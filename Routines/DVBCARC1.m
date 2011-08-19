DVBCARC1 ;ALB ISC/THM-TEXT FOR A&A/HOUSEBOUND EXAM ; 5/17/91  9:16 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
PTXT F AW=0:1 S AX=$T(@TXT+AW) S AY=$P(AX,";;",2) D:AY["|TOP|" HD2^DVBCARCK W:AY="END" !! Q:AY="END"  I AY'["|TOP|" W AY,!
 G:TXT="TXT3" ^DVBCARC2 Q
 ;
TXT2 ;;A.  Indicate whether or not the veteran REQUIRES an attendant in reporting
 ;;    for this exam, and if so, identify the nurse or attendant and the
 ;;    mode of travel employed:
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;B.  Indicate whether or not the veteran is hospitalized, and if so, state
 ;;    where and the date of admission:
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;C.  Indicate whether or not the veteran is blind (best corrected vision
 ;;    is 5/200 or worse in both eyes, or central vision field is five degrees
 ;;    or less) or is permanently bedridden (if either skip items "D" through
 ;;    "I" and go directly to "J"):
 ;;END
TXT3 ;;
 ;;
 ;;
 ;;F.  Extremeties and spine:
 ;;
 ;;    1.  Upper extremities (reporting each upper extremity separately) -
 ;;
 ;;        a.  Describe functional restrictions with reference to strength
 ;;and coordination and ability for self-feeding, fastening clothing, bathing,
 ;;shaving, and attending to the needs of nature -
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;        b.  Indicate level of amputation or length of stump and state
 ;;whether or not use of prothesis is feasible -
 ;;|TOP|
 ;;
 ;;
 ;;    2.  Lower extremities (reporting each lower extremity separately) -
 ;;
 ;;        a.  Describe functional restrictions with reference to extent
 ;;of limitation of motion, muscle atrophy, contractures, weakness, lack
 ;;of coordination, or other interference -
 ;;
 ;;
 ;;
 ;;        b.  Indicate any deficits of weight bearing, balance and propulsion -
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;        c.  If amputated, give level or length of stump and whether use
 ;;of prosthesis is feasible -
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;    3.  Spine, trunk, and neck -
 ;;
 ;;        a.  Describe any limitation of motion or deformity of lumbar,
 ;;thoracic, and cervical spine -
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;        b.  Note if deformity of thoracic spine interferes with breathing -
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;G.  Capacity to protect oneself from the hazards/dangers of daily environment:
 ;;
 ;;    1.  Describe briefly any pathological processes involving other body
 ;;parts and systems, including the effects of advancing age, such as dizziness,
 ;;loss of memory, poor balance affecting ability to ambulate, perform self-
 ;;care, or travel beyond the premises of the home or the ward or clinical
 ;;area if hospitalized -
 ;;|TOP|
 ;;    2.  Describe where the veteran goes and what he/she does during a
 ;;typical day -
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;END
 ;
TXT10 ;;Once the existence of at least one permanent disability
 ;;            rated as being 100% disabling has been established, additional
 ;;            benefits are payable if the veteran is so helpless as to require
 ;;            the regular aid and attendance of another person in attending to
 ;;            the ordinary activities of daily living, or in protecting
 ;;            himself/herself from the ordinary hazards of his/her daily
 ;;            environment, or is restricted to his/her home or the immediate
 ;;            vicinity thereof, including the ward or immediate clinical area,
 ;;            if hospitalized.
 ;;
 ;;            If a general medical examination is included as a part of this
 ;;            request specific findings as to the individual body systems and
 ;;            extremeties already noted in that examination need not be repeated.
 ;;            Items "G" through "L", as the examiner deems appropriate, must be
 ;;            completed in all cases unless the veteran is blind or permanently
 ;;            bedridden (see item "C").
 ;;
 ;;END
