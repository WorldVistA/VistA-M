IBCEMSR4  ;BI/ALB - non-MRA PRODUCTIVITY REPORT ;02/14/11
 ;;2.0;INTEGRATED BILLING;**447**;21-MAR-94;Build 80
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
FFORM  ; Detail FORM Setup
 ;;LINE#;IBACCUM ;TAB^LABEL                                     ^TAB^$J^#D^TAB^LABEL                                      ^TAB^$J^#D
 ;;1    ;        ;3  ^Primary UB04 Claim EEOBs                  ^41 ^  ^  ^63 ^Primary CMS-1500 Claim EEOBs               ^101^  ^
 ;;2    ;        ;3  ^--------------------------                ^41 ^  ^  ^63 ^-----------------------------              ^101^  ^
 ;;3    ;FPA     ;3  ^Total number of Processed EOBs:           ^41 ^14^0 ^63 ^Total number of Processed EEOBs:           ^101^14^0
 ;;4    ;FPAA    ;6  ^Number Auto-processed to 2ndary:          ^41 ^14^0 ^66 ^Number Auto-processed to 2ndary:           ^101^14^0
 ;;5    ;FPAAA   ;9  ^Number Printed locally:                   ^41 ^14^0 ^69 ^Number Printed locally:                    ^101^14^0
 ;;6    ;FPAAA1  ;12 ^Total secondary charges:                  ^41 ^14^2 ^72 ^Total secondary charges:                   ^101^14^2
 ;;7    ;FPAAB   ;9  ^Number Transmitted:                       ^41 ^14^0 ^69 ^Number Transmitted:                        ^101^14^0
 ;;8    ;FPAAB1  ;12 ^Total secondary charges:                  ^41 ^14^2 ^72 ^Total secondary charges:                   ^101^14^2
 ;;9    ;FPAB    ;6  ^Total number Sent to worklist:            ^41 ^14^0 ^66 ^Total number Sent to worklist:             ^101^14^0
 ;;10   ;FPABA   ;9  ^Number Processed from worklist:           ^41 ^14^0 ^69 ^Number Processed from worklist:            ^101^14^0
 ;;11   ;FPABA1  ;12 ^Total secondary charges:                  ^41 ^14^2 ^72 ^Total secondary charges:                   ^101^14^2
 ;;12   ;FPABB   ;9  ^Number Removed from worklist:             ^41 ^14^0 ^69 ^Number Removed from worklist:              ^101^14^0
 ;;13   ;FPABB1  ;12 ^Total secondary charges:                  ^41 ^14^2 ^72 ^Total secondary charges:                   ^101^14^2
 ;;14   ;FPABC   ;9  ^Number Cancelled from worklist:           ^41 ^14^0 ^69 ^Number Cancelled from worklist:            ^101^14^0
 ;;15   ;FPABC1  ;12 ^Total secondary charges:                  ^41 ^14^2 ^72 ^Total secondary charges:                   ^101^14^2
 ;;16   ;FPABD   ;9  ^Number Still on worklist:                 ^41 ^14^0 ^69 ^Number Still on worklist:                  ^101^14^0
 ;;17   ;FPABD1  ;12 ^Total secondary charges:                  ^41 ^14^2 ^72 ^Total secondary charges:                   ^101^14^2
 ;;18   ;FPNCC   ;6  ^Number of EEOBs not collected/closed:     ^45 ^10^0 ^66 ^Number of EEOBs not collected/closed:      ^105^10^0
 ;;19   ;FPWOS   ;6  ^Number of Closed EEOBs w/out 2ndary:      ^45 ^10^0 ^66 ^Number of Closed EEOBs w/out 2ndary:       ^105^10^0
 ;;20   ;FPB     ;3  ^Total number of Denied EEOBs w/2ndary:    ^41 ^14^0 ^63 ^Total number of Denied EEOBs w/2ndary:     ^101^14^0
 ;;21   ;FPSOW   ;6  ^Number Still on Worklist:                 ^41 ^14^0 ^66 ^Number Still on Worklist:                  ^101^14^0
 ;;22   ;FPBXD   ;6  ^Number Processed from worklist:           ^41 ^14^0 ^66 ^Number Processed from worklist:            ^101^14^0
 ;;23   ;FPBXA   ;6  ^Number Removed from worklist:             ^41 ^14^0 ^66 ^Number Removed from worklist:              ^101^14^0
 ;;24   ;FPBXE   ;6  ^Number Cancelled from worklist:           ^41 ^14^0 ^66 ^Number Cancelled from worklist:            ^101^14^0
 ;;25   ;FPBXB   ;6  ^Number Corrected from worklist:           ^41 ^14^0 ^66 ^Number Corrected from worklist:            ^101^14^0
 ;;26   ;FPBXB1  ;9  ^Total primary charges:                    ^41 ^14^2 ^69 ^Total primary charges:                     ^101^14^2
 ;;27   ;FPBXC   ;6  ^Number Cloned from worklist:              ^41 ^14^0 ^66 ^Number Cloned from worklist:               ^101^14^0
 ;;28   ;FPBXC1  ;9  ^Total primary charges:                    ^41 ^14^2 ^69 ^Total primary charges:                     ^101^14^2
 ;;29   ;        ;20 ^                                          ^41 ^  ^  ^   ^                                           ^101^  ^
 ;;30   ;        ;3  ^Secondary UB04 Claim EEOBs                ^41 ^  ^  ^63 ^Secondary CMS-1500 Claim EEOBs             ^101^  ^
 ;;31   ;        ;3  ^--------------------------                ^41 ^  ^  ^63 ^-----------------------------              ^101^  ^
 ;;32   ;FSA     ;3  ^Total number of Processed EOBs:           ^41 ^14^0 ^63 ^Total number of Processed EEOBs:           ^101^14^0
 ;;33   ;FSAA    ;6  ^Number Auto-processed to 2ndary:          ^41 ^14^0 ^66 ^Number Auto-processed to 2ndary:           ^101^14^0
 ;;34   ;FSAAA   ;9  ^Number Printed locally:                   ^41 ^14^0 ^69 ^Number Printed locally:                    ^101^14^0
 ;;35   ;FSAAA1  ;12 ^Total tertiary charges:                   ^41 ^14^2 ^72 ^Total tertiary charges:                    ^101^14^2
 ;;36   ;FSAAB   ;9  ^Number Transmitted:                       ^41 ^14^0 ^69 ^Number Transmitted:                        ^101^14^0
 ;;37   ;FSAAB1  ;12 ^Total tertiary charges:                   ^41 ^14^2 ^72 ^Total tertiary charges:                    ^101^14^2
 ;;38   ;FSAB    ;6  ^Total number Sent to worklist:            ^41 ^14^0 ^66 ^Total number Sent to worklist:             ^101^14^0
 ;;39   ;FSABA   ;9  ^Number Processed from worklist:           ^41 ^14^0 ^69 ^Number Processed from worklist:            ^101^14^0
 ;;40   ;FSABA1  ;12 ^Total tertiary charges:                   ^41 ^14^2 ^72 ^Total tertiary charges:                    ^101^14^2
 ;;41   ;FSABB   ;9  ^Number Removed from worklist:             ^41 ^14^0 ^69 ^Number Removed from worklist:              ^101^14^0
 ;;42   ;FSABB1  ;12 ^Total tertiary charges:                   ^41 ^14^2 ^72 ^Total tertiary charges:                    ^101^14^2
 ;;43   ;FSABC   ;9  ^Number Cancelled from worklist:           ^41 ^14^0 ^69 ^Number Cancelled from worklist:            ^101^14^0
 ;;44   ;FSABC1  ;12 ^Total tertiary charges:                   ^41 ^14^2 ^72 ^Total tertiary charges:                    ^101^14^2
 ;;45   ;FSABD   ;9  ^Number Still on worklist:                 ^41 ^14^0 ^69 ^Number Still on worklist:                  ^101^14^0
 ;;46   ;FSABD1  ;12 ^Total tertiary charges:                   ^41 ^14^2 ^72 ^Total tertiary charges:                    ^101^14^2
 ;;47   ;FSNCC   ;6  ^Number of EEOBs not collected/closed:     ^45 ^10^0 ^66 ^Number of EEOBs not collected/closed:      ^105^10^0
 ;;48   ;FSWOT   ;6  ^Number of Closed EEOBs w/out tertiary:    ^45 ^10^0 ^66 ^Number of Closed EEOBs w/out tertiary:     ^105^10^0
 ;;49   ;FSB     ;3  ^Total number of Denied EEOBs w/Tertiary:  ^46 ^9 ^0 ^63 ^Total number of Denied EEOBs w/Tertiary:   ^105^10^0
 ;;50   ;FSSOW   ;6  ^Number Still on Worklist:                 ^41 ^14^0 ^66 ^Number Still on Worklist:                  ^101^14^0
 ;;51   ;FSBXD   ;6  ^Number Processed from worklist:           ^41 ^14^0 ^66 ^Number Processed from worklist:            ^101^14^0
 ;;52   ;FSBXA   ;6  ^Number Removed from worklist:             ^41 ^14^0 ^66 ^Number Removed from worklist:              ^101^14^0
 ;;53   ;FSBXE   ;6  ^Number Cancelled from worklist:           ^41 ^14^0 ^66 ^Number Cancelled from worklist:            ^101^14^0
 ;;54   ;FSBXB   ;6  ^Number Corrected from worklist:           ^41 ^14^0 ^66 ^Number Corrected from worklist:            ^101^14^0
 ;;55   ;FSBXB1  ;9  ^Total secondary charges:                  ^41 ^14^2 ^69 ^Total secondary charges:                   ^101^14^2
 ;;56   ;FSBXC   ;6  ^Number Cloned from worklist:              ^41 ^14^0 ^66 ^Number Cloned from worklist:               ^101^14^0
 ;;57   ;FSBXC1  ;9  ^Total secondary charges:                  ^41 ^14^2 ^69 ^Total secondary charges:                   ^101^14^2
 ;;END
 Q
 ;
SFORM  ; Summary FORM Setup
 ;;LINE#;IBACCUM ;TAB^LABEL                                     ^TAB^$J^#D^TAB^LABEL                                      ^TAB^$J^#D
 ;;1    ;        ;3  ^Primary UB04 Claim EEOBs                  ^41 ^  ^  ^63 ^Primary CMS-1500 Claim EEOBs               ^101^  ^
 ;;2    ;        ;3  ^--------------------------                ^41 ^  ^  ^63 ^-----------------------------              ^101^  ^
 ;;3    ;SPA     ;3  ^Total number of EEOBs received:           ^41 ^14^0 ^63 ^Total number of EEOBs received:            ^101^14^0
 ;;4    ;SPACL   ;3  ^Number of unique EEOBs received:          ^41 ^14^0 ^63 ^Number of unique EEOBs received:           ^101^14^0
 ;;5    ;SPAA    ;6  ^% Processed:                              ^41 ^15^  ^66 ^% Processed:                               ^101^15^
 ;;6    ;SPAB    ;6  ^% of Processed auto-processed to 2ndary:  ^46 ^10^  ^66 ^% of Processed auto-processed to 2ndary:   ^106^10^
 ;;7    ;SPAC    ;6  ^Number of Processed EEOBs:                ^41 ^14^0 ^66 ^Number of Processed EEOBs:                 ^101^14^0
 ;;8    ;SPACA   ;9  ^Number Auto-processed to 2ndary:          ^42 ^13^0 ^69 ^Number Auto-processed to 2ndary:           ^110^5 ^0
 ;;9    ;SPACAA  ;12 ^Number Printed locally:                   ^41 ^14^0 ^72 ^Number Printed locally:                    ^101^14^0
 ;;10   ;SPACAA1 ;15 ^Total secondary charges:                  ^41 ^14^2 ^75 ^Total secondary charges:                   ^101^14^2
 ;;11   ;SPACAB  ;12 ^Number Transmitted:                       ^41 ^14^0 ^72 ^Number Transmitted:                        ^101^14^0
 ;;12   ;SPACAB1 ;15 ^Total secondary charges:                  ^41 ^14^2 ^75 ^Total secondary charges:                   ^101^14^2
 ;;13   ;SPACB   ;9  ^Number Manually Processed to 2ndary:      ^50 ^5 ^0 ^69 ^Number Manually Processed to 2ndary:       ^110^5 ^0
 ;;14   ;SPACBA  ;12 ^Number Printed locally:                   ^41 ^14^0 ^72 ^Number Printed locally:                    ^101^14^0
 ;;15   ;SPACBA1 ;15 ^Total secondary charges:                  ^41 ^14^2 ^75 ^Total secondary charges:                   ^101^14^2
 ;;16   ;SPACBB  ;12 ^Number Transmitted:                       ^41 ^14^0 ^72 ^Number Transmitted:                        ^101^14^0
 ;;17   ;SPACBB1 ;15 ^Total secondary charges:                  ^41 ^14^2 ^75 ^Total secondary charges:                   ^101^14^2
 ;;18   ;SPNCC   ;9  ^Number of EEOBs not collected/closed:     ^50 ^5 ^0 ^69 ^Number of EEOBs not collected/closed:      ^110^5 ^0
 ;;19   ;SPWOS   ;9  ^Number of Closed EEOBs w/out 2ndary:      ^50 ^5 ^0 ^69 ^Number of Closed EEOBs w/out 2ndary:       ^110^5 ^0
 ;;20   ;SPABD   ;9  ^Number of EEOBs Still on worklist:        ^50 ^5 ^0 ^69 ^Number of EEOBs Still on worklist:         ^110^5 ^0
 ;;21   ;SPAD    ;6  ^Number of Denied EEOBs:                   ^41 ^14^0 ^66 ^Number of Denied EEOBS:                    ^101^14^0
 ;;22   ;        ;3  ^                                          ^41 ^  ^  ^   ^                                           ^101^  ^
 ;;23   ;        ;3  ^Secondary UB04 Claim EEOBs                ^41 ^  ^  ^63 ^Secondary CMS-1500 Claim EEOBs             ^101^  ^
 ;;24   ;        ;3  ^--------------------------                ^41 ^  ^  ^63 ^   -----------------------------           ^101^  ^
 ;;25   ;SSA     ;3  ^Total number of EEOBs received:           ^41 ^14^0 ^63 ^Total number of EEOBs received:            ^101^14^0
 ;;26   ;SSACL   ;3  ^Number of unique EEOBs received:          ^41 ^14^0 ^63 ^Number of unique EEOBs received:           ^101^14^0
 ;;27   ;SSAA    ;6  ^% Processed:                              ^41 ^15^  ^66 ^% Processed:                               ^101^15^
 ;;28   ;SSAB    ;6  ^% of Processed auto-processed to tertiary:^49 ^7 ^  ^66 ^% of Processed auto-processed to tertiary: ^110^6 ^
 ;;29   ;SSAC    ;6  ^Number of Processed EEOBs:                ^41 ^14^0 ^66 ^Number of Processed EEOBs:                 ^101^14^0
 ;;30   ;SSACA   ;9  ^Number Auto-processed to tertiary:        ^44 ^11^0 ^69 ^Number Auto-processed to tertiary:         ^110^5 ^0
 ;;31   ;SSACAA  ;12 ^Number Printed locally:                   ^41 ^14^0 ^72 ^Number Printed locally:                    ^101^14^0
 ;;32   ;SSACAA1 ;15 ^Total tertiary charges:                   ^41 ^14^2 ^75 ^Total tertiary charges:                    ^101^14^2
 ;;33   ;SSACAB  ;12 ^Number Transmitted:                       ^41 ^14^0 ^72 ^Number Transmitted:                        ^101^14^0
 ;;34   ;SSACAB1 ;15 ^Total tertiary charges:                   ^41 ^14^2 ^75 ^Total tertiary charges:                    ^101^14^2
 ;;35   ;SSADA   ;9  ^Number Manually Processed to tertiary:    ^50 ^5 ^0 ^69 ^Number Manually Processed to tertiary:     ^110^5 ^0
 ;;36   ;SSADAA  ;12 ^Number Printed locally:                   ^41 ^14^0 ^72 ^Number Printed locally:                    ^101^14^0
 ;;37   ;SSADAA1 ;15 ^Total tertiary charges:                   ^41 ^14^2 ^75 ^Total tertiary charges:                    ^101^14^2
 ;;38   ;SSADAB  ;12 ^Number Transmitted:                       ^41 ^14^0 ^72 ^Number Transmitted:                        ^101^14^0
 ;;39   ;SSADAB1 ;15 ^Total tertiary charges:                   ^41 ^14^2 ^75 ^Total tertiary charges:                    ^101^14^2
 ;;40   ;SSNCC   ;9  ^Number of EEOBs not collected/closed:     ^50 ^5 ^0 ^69 ^Number of EEOBs not collected/closed:      ^110^5 ^0
 ;;41   ;SSWOT   ;9  ^Number of Closed EEOBs w/out tertiary:    ^50 ^5 ^0 ^69 ^Number of Closed EEOBs w/out tertiary:     ^110^5 ^0
 ;;42   ;SSABD   ;9  ^Number of EEOBs Still on worklist:        ^50 ^5 ^0 ^69 ^Number of EEOBs Still on worklist:         ^110^5 ^0
 ;;43   ;SSAD    ;6  ^Number of Denied EEOBs:                   ^41 ^14^0 ^66 ^Number of Denied EEOBS:                    ^101^14^0
 ;;END
 Q
