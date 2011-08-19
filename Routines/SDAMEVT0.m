SDAMEVT0 ;ALB/MJK - Appt Event Driver Utilities ; 12/1/91
 ;;5.3;Scheduling;;Aug 13, 1993
 ;
 ;
 ;  *** documentation for tags in SDAMEVT ***
 ;   input:      DFN := ifn of pat.
 ;               SDT := appt d/t
 ;              SDCL := ifn of clinic
 ;              SDDA := ifn for ^SC(clinic,"S",date,1,ifn)
 ;             SDATA := where 'before' and 'after' status data is stored
 ;           SDAMEVT := what event is taking place / ifn to ^SD(409.66)
 ;            SDMODE := parameter that tells function the 
 ;                      conversation mode desired by caller
 ;                            0 = full dialogue
 ;                            1 = conputer monologue
 ;                            2 = quiet
 ;             SDORG := originating transaction
 ;                            1 = appointment
 ;                            2 = add/edit stop code
 ;                            3 = registration disposition
 ;             SDCAP := capture mode (before or after)
