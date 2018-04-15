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

val restart : string -> (unit, unit) Result.result
val start : string -> (unit, unit) Result.result
val stop : string -> (unit, unit) Result.result

val set_restart_ms : string -> restart_ms:Stdint.uint32 -> (unit, unit) Result.result
val set_bittiming : string -> bittiming -> (unit, unit) Result.result
val set_ctrlmode : string -> ctrlmode -> (unit, unit) Result.result

val set_bitrate : string -> bitrate:Stdint.uint32 -> (unit, unit) Result.result
val set_bitrate_samplepoint : string -> bitrate:Stdint.uint32 -> sample_point:Stdint.uint32 -> (unit, unit) Result.result

val get_restart_ms : string -> (Stdint.uint32, unit) Result.result
val get_bittiming : string -> (bittiming, unit) Result.result
val get_ctrlmode : string -> (ctrlmode, unit) Result.result
val get_state : string -> (state, unit) Result.result
val get_clock : string -> (Stdint.uint32, unit) Result.result
val get_bittiming_const : string -> (bittiming_const, unit) Result.result
val get_berr_counter : string -> (berr_counter, unit) Result.result
val get_device_stats : string -> (device_stats, unit) Result.result

