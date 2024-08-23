module Types (F : Cstubs.Types.TYPE) = struct
  open F
  open struct
    type 'a abstract = 'a Ctypes.abstract
    type 'a structure = 'a Ctypes.structure
    let (%) f g = fun x -> f (g x)
    let uint_of_int = Unsigned.UInt.of_int
    let uint_to_int = Unsigned.UInt.to_int
  end

  (* Since ctypes doesn't have const ptrs. *)
  module Ptr : sig
    type ('a, -'perm) t
    val ro : 'a Ctypes.ptr -> ('a, [`Read]) t
    val rw : 'a Ctypes.ptr -> ('a, [`Read|`Write]) t
    val get : ('a, [`Read|`Write]) t -> 'a Ctypes.ptr
    val unsafe_get : ('a, 'perm) t -> 'a Ctypes.ptr
    val raw_address : ('a, 'perm) t -> nativeint
    val const : ('a, [>`Read]) t -> ('a, [`Read]) t
  end = struct
    type ('a, -'perm) t = 'a Ctypes.ptr
    let ro x = x
    let rw x = x
    let get x = x
    let unsafe_get x = x
    let raw_address x = Ctypes.raw_address_of_ptr @@ Ctypes.to_voidp x
    let const x = x
  end

  type encoder_operand
  let encoder_operand : encoder_operand structure typ = structure "xed_encoder_operand_t"
  type enc_displacement
  let enc_displacement : enc_displacement structure typ = structure "xed_enc_displacement_t"
  type chip_features
  let chip_features : chip_features abstract typ = abstract ~name:"xed_chip_features_t" ~size:56 ~alignment:8
  let const_chip_features_ptr = view ~read:Ptr.ro ~write:Ptr.unsafe_get @@ ptr chip_features
  let chip_features_ptr = view ~read:Ptr.rw ~write:Ptr.get @@ ptr chip_features
  type 'a chip_features_ptr = (chip_features abstract, 'a) Ptr.t
  type decoded_inst
  let decoded_inst : decoded_inst abstract typ = abstract ~name:"xed_decoded_inst_t" ~size:208 ~alignment:8
  let const_decoded_inst_ptr = view ~read:Ptr.ro ~write:Ptr.unsafe_get @@ ptr decoded_inst
  let decoded_inst_ptr = view ~read:Ptr.rw ~write:Ptr.get @@ ptr decoded_inst
  type 'a decoded_inst_ptr = (decoded_inst abstract, 'a) Ptr.t
  type encoder_instruction
  let encoder_instruction : encoder_instruction abstract typ = abstract ~name:"xed_encoder_instruction_t" ~size:416 ~alignment:8
  let const_encoder_instruction_ptr = view ~read:Ptr.ro ~write:Ptr.unsafe_get @@ ptr encoder_instruction
  let encoder_instruction_ptr = view ~read:Ptr.rw ~write:Ptr.get @@ ptr encoder_instruction
  type 'a encoder_instruction_ptr = (encoder_instruction abstract, 'a) Ptr.t
  type encoder_request
  let encoder_request : encoder_request abstract typ = abstract ~name:"xed_encoder_request_t" ~size:208 ~alignment:8
  let const_encoder_request_ptr = view ~read:Ptr.ro ~write:Ptr.unsafe_get @@ ptr encoder_request
  let encoder_request_ptr = view ~read:Ptr.rw ~write:Ptr.get @@ ptr encoder_request
  type 'a encoder_request_ptr = (encoder_request abstract, 'a) Ptr.t
  type flag_action
  let flag_action : flag_action abstract typ = abstract ~name:"xed_flag_action_t" ~size:8 ~alignment:4
  let const_flag_action_ptr = view ~read:Ptr.ro ~write:Ptr.unsafe_get @@ ptr flag_action
  let flag_action_ptr = view ~read:Ptr.rw ~write:Ptr.get @@ ptr flag_action
  type 'a flag_action_ptr = (flag_action abstract, 'a) Ptr.t
  type flag_dfv
  let flag_dfv : flag_dfv abstract typ = abstract ~name:"xed_flag_dfv_t" ~size:4 ~alignment:4
  let const_flag_dfv_ptr = view ~read:Ptr.ro ~write:Ptr.unsafe_get @@ ptr flag_dfv
  let flag_dfv_ptr = view ~read:Ptr.rw ~write:Ptr.get @@ ptr flag_dfv
  type 'a flag_dfv_ptr = (flag_dfv abstract, 'a) Ptr.t
  type flag_set
  let flag_set : flag_set abstract typ = abstract ~name:"xed_flag_set_t" ~size:4 ~alignment:4
  let const_flag_set_ptr = view ~read:Ptr.ro ~write:Ptr.unsafe_get @@ ptr flag_set
  let flag_set_ptr = view ~read:Ptr.rw ~write:Ptr.get @@ ptr flag_set
  type 'a flag_set_ptr = (flag_set abstract, 'a) Ptr.t
  type inst
  let inst : inst abstract typ = abstract ~name:"xed_inst_t" ~size:12 ~alignment:2
  let const_inst_ptr = view ~read:Ptr.ro ~write:Ptr.unsafe_get @@ ptr inst
  let inst_ptr = view ~read:Ptr.rw ~write:Ptr.get @@ ptr inst
  type 'a inst_ptr = (inst abstract, 'a) Ptr.t
  type operand
  let operand : operand abstract typ = abstract ~name:"xed_operand_t" ~size:12 ~alignment:4
  let const_operand_ptr = view ~read:Ptr.ro ~write:Ptr.unsafe_get @@ ptr operand
  let operand_ptr = view ~read:Ptr.rw ~write:Ptr.get @@ ptr operand
  type 'a operand_ptr = (operand abstract, 'a) Ptr.t
  type operand_values
  let operand_values : operand_values abstract typ = abstract ~name:"xed_operand_values_t" ~size:208 ~alignment:8
  let const_operand_values_ptr = view ~read:Ptr.ro ~write:Ptr.unsafe_get @@ ptr operand_values
  let operand_values_ptr = view ~read:Ptr.rw ~write:Ptr.get @@ ptr operand_values
  type 'a operand_values_ptr = (operand_values abstract, 'a) Ptr.t
  type simple_flag
  let simple_flag : simple_flag abstract typ = abstract ~name:"xed_simple_flag_t" ~size:20 ~alignment:4
  let const_simple_flag_ptr = view ~read:Ptr.ro ~write:Ptr.unsafe_get @@ ptr simple_flag
  let simple_flag_ptr = view ~read:Ptr.rw ~write:Ptr.get @@ ptr simple_flag
  type 'a simple_flag_ptr = (simple_flag abstract, 'a) Ptr.t
  type state
  let state : state abstract typ = abstract ~name:"xed_state_t" ~size:8 ~alignment:4
  let const_state_ptr = view ~read:Ptr.ro ~write:Ptr.unsafe_get @@ ptr state
  let state_ptr = view ~read:Ptr.rw ~write:Ptr.get @@ ptr state
  type 'a state_ptr = (state abstract, 'a) Ptr.t
  let address_width_enum = view
      ~read:(XBEnums.address_width_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.address_width_to_int)
      @@ typedef uint "xed_address_width_enum_t"
  let attribute_enum = view
      ~read:(XBEnums.attribute_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.attribute_to_int)
      @@ typedef uint "xed_attribute_enum_t"
  let category_enum = view
      ~read:(XBEnums.category_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.category_to_int)
      @@ typedef uint "xed_category_enum_t"
  let chip_enum = view
      ~read:(XBEnums.chip_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.chip_to_int)
      @@ typedef uint "xed_chip_enum_t"
  let cpuid_group_enum = view
      ~read:(XBEnums.cpuid_group_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.cpuid_group_to_int)
      @@ typedef uint "xed_cpuid_group_enum_t"
  let cpuid_rec_enum = view
      ~read:(XBEnums.cpuid_rec_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.cpuid_rec_to_int)
      @@ typedef uint "xed_cpuid_rec_enum_t"
  let error_enum = view
      ~read:(XBEnums.error_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.error_to_int)
      @@ typedef uint "xed_error_enum_t"
  let extension_enum = view
      ~read:(XBEnums.extension_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.extension_to_int)
      @@ typedef uint "xed_extension_enum_t"
  let flag_enum = view
      ~read:(XBEnums.flag_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.flag_to_int)
      @@ typedef uint "xed_flag_enum_t"
  let flag_action_enum = view
      ~read:(XBEnums.flag_action_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.flag_action_to_int)
      @@ typedef uint "xed_flag_action_enum_t"
  let iclass_enum = view
      ~read:(XBEnums.iclass_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.iclass_to_int)
      @@ typedef uint "xed_iclass_enum_t"
  let iexception_enum = view
      ~read:(XBEnums.iexception_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.iexception_to_int)
      @@ typedef uint "xed_exception_enum_t"
  let iform_enum = view
      ~read:(XBEnums.iform_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.iform_to_int)
      @@ typedef uint "xed_iform_enum_t"
  let isa_set_enum = view
      ~read:(XBEnums.isa_set_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.isa_set_to_int)
      @@ typedef uint "xed_isa_set_enum_t"
  let machine_mode_enum = view
      ~read:(XBEnums.machine_mode_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.machine_mode_to_int)
      @@ typedef uint "xed_machine_mode_enum_t"
  let nonterminal_enum = view
      ~read:(XBEnums.nonterminal_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.nonterminal_to_int)
      @@ typedef uint "xed_nonterminal_enum_t"
  let operand_enum = view
      ~read:(XBEnums.operand_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.operand_to_int)
      @@ typedef uint "xed_operand_enum_t"
  let operand_action_enum = view
      ~read:(XBEnums.operand_action_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.operand_action_to_int)
      @@ typedef uint "xed_operand_action_enum_t"
  let operand_convert_enum = view
      ~read:(XBEnums.operand_convert_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.operand_convert_to_int)
      @@ typedef uint "xed_operand_convert_enum_t"
  let operand_element_type_enum = view
      ~read:(XBEnums.operand_element_type_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.operand_element_type_to_int)
      @@ typedef uint "xed_operand_element_type_enum_t"
  let operand_element_xtype_enum = view
      ~read:(XBEnums.operand_element_xtype_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.operand_element_xtype_to_int)
      @@ typedef uint "xed_operand_element_xtype_enum_t"
  let operand_type_enum = view
      ~read:(XBEnums.operand_type_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.operand_type_to_int)
      @@ typedef uint "xed_operand_type_enum_t"
  let operand_visibility_enum = view
      ~read:(XBEnums.operand_visibility_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.operand_visibility_to_int)
      @@ typedef uint "xed_operand_visibility_enum_t"
  let operand_width_enum = view
      ~read:(XBEnums.operand_width_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.operand_width_to_int)
      @@ typedef uint "xed_operand_width_enum_t"
  let reg_enum = view
      ~read:(XBEnums.reg_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.reg_to_int)
      @@ typedef uint "xed_reg_enum_t"
  let reg_class_enum = view
      ~read:(XBEnums.reg_class_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.reg_class_to_int)
      @@ typedef uint "xed_reg_class_enum_t"
  let syntax_enum = view
      ~read:(XBEnums.syntax_of_int % uint_to_int)
      ~write:(uint_of_int % XBEnums.syntax_to_int)
      @@ typedef uint "xed_syntax_enum_t"
end
