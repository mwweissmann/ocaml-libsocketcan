external initialize : unit -> unit = "libsc_initialize"
let () = initialize ()

type state =
  | CAN_STATE_ERROR_ACTIVE
  | CAN_STATE_ERROR_WARNING
  | CAN_STATE_ERROR_PASSIVE
  | CAN_STATE_BUS_OFF
  | CAN_STATE_STOPPED
  | CAN_STATE_SLEEPING

type bittiming = {
    bitrate : Stdint.uint32;
    sample_point : Stdint.uint32;
    tq : Stdint.uint32;
    prop_seg : Stdint.uint32;
    phase_seg1 : Stdint.uint32;
    phase_seg2 : Stdint.uint32;
    sjw : Stdint.uint32;
    brp : Stdint.uint32;
  }

type bittiming_const = {
    name : string;
    tseg1_min : Stdint.uint32;
    tseg1_max : Stdint.uint32;
    tseg2_min : Stdint.uint32;
    tseg2_max : Stdint.uint32;
    sjw_max : Stdint.uint32;
    brp_min : Stdint.uint32;
    brp_max : Stdint.uint32;
    brp_inc : Stdint.uint32;
  }

type berr_counter = {
    txerr : Stdint.int16;
    rxerr : Stdint.int16;
  }

type ctrlmode = {
    mask : Stdint.uint32;
    flags : Stdint.uint32;
  }

type device_stats = {
    bus_error : Stdint.uint32;
    error_warning : Stdint.uint32;
    error_passive : Stdint.uint32;
    bus_off : Stdint.uint32;
    arbitration_lost : Stdint.uint32;
    restarts : Stdint.uint32;
  }

external restart : string -> (unit, [> `EUnix of Unix.error]) Result.result = "libsc_restart"
external start : string -> (unit, [> `EUnix of Unix.error]) Result.result = "libsc_start"
external stop : string -> (unit, [> `EUnix of Unix.error]) Result.result = "libsc_stop"

external set_restart_ms : string -> restart_ms:Stdint.uint32 -> (unit, [> `EUnix of Unix.error]) Result.result = "libsc_set_restart_ms"
external set_bittiming : string -> bittiming -> (unit, [> `EUnix of Unix.error]) Result.result = "libsc_set_bittiming"
external set_ctrlmode : string -> ctrlmode -> (unit, [> `EUnix of Unix.error]) Result.result = "libsc_set_ctrlmode"

external set_bitrate : string -> bitrate:Stdint.uint32 -> (unit, [> `EUnix of Unix.error]) Result.result = "libsc_set_bitrate"
external set_bitrate_samplepoint : string -> bitrate:Stdint.uint32 -> sample_point:Stdint.uint32 -> (unit, [> `EUnix of Unix.error]) Result.result = "libsc_set_bitrate_samplepoint"

external get_restart_ms : string -> (Stdint.uint32, [> `EUnix of Unix.error]) Result.result = "libsc_get_restart_ms"
external get_bittiming : string -> (bittiming, [> `EUnix of Unix.error]) Result.result = "libsc_get_bittiming"
external get_ctrlmode : string -> (ctrlmode, [> `EUnix of Unix.error]) Result.result = "libsc_get_ctrlmode"
external get_state : string -> (state, [> `EUnix of Unix.error]) Result.result = "libsc_get_state"
external get_clock : string -> (Stdint.uint32, [> `EUnix of Unix.error]) Result.result = "libsc_get_clock"
external get_bittiming_const : string -> (bittiming_const, [> `EUnix of Unix.error]) Result.result = "libsc_get_bittiming_const"
external get_berr_counter : string -> (berr_counter, [> `EUnix of Unix.error]) Result.result = "libsc_get_berr_counter"
external get_device_stats : string -> (device_stats, [> `EUnix of Unix.error]) Result.result = "libsc_get_device_stats"

