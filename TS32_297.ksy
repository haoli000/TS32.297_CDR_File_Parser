meta:
  id: threegpp_cdr
  endian: be

seq:
  - id: header
    type: header
  - id: cdrs
    type: cdr
    repeat: eos

types:
  header:
    seq:
      - id: file_length
        type: u4
      - id: header_length
        type: u4
      - id: high_release_version_identifier
        type: release_version_identifier
      - id: low_release_version_identifier
        type: release_version_identifier
      - id: file_opening_timestamp
        type: timestamp
      - id: last_cdr_append_timestamp
        type: timestamp
      - id: number_of_cdrs_in_file
        type: u4
      - id: file_sequence_number
        type: u4
      - id: file_closure_trigger_reason
        type: u1
      - id: node_ip_address
        type: ip_address
      - id: lost_cdr_indicator
        type: u1
      - id: length_of_cdr_routeing_filter
        type: u2
      - id: cdr_routeing_filter
        type: str
        size: length_of_cdr_routeing_filter
        encoding: UTF-8
      - id: length_of_private_extension
        type: u2
      - id: private_extension
        type: str
        size: length_of_private_extension
        encoding: UTF-8
      - id: high_release_identifier_extension
        type: release_identifier_extension
        if: high_release_version_identifier.release_identifier == 7
      - id: low_release_identifier_extension
        type: release_identifier_extension
        if: high_release_version_identifier.release_identifier == 7

  release_version_identifier:
    seq:
      - id: release_identifier
        type: b3
      - id: version_identifier
        type: b5
    instances:
      threegpp_release:
        value: 0 + release_identifier
        enum: rel
    enums:
      rel:
        0: r99
        1: r4
        2: r5
        3: r6
        4: r7
        5: r8
        6: r9
        7: beyond_9

  release_identifier_extension:
    seq:
      - id: threegpp_release
        type: u1
        enum: rel
    enums:
      rel:
        0: r10
        1: r11
        2: r12
        3: r13
        4: r14
        5: r15
        6: r16

  timestamp:
    seq:
      - id: month
        type: b4
      - id: date
        type: b5
      - id: hour
        type: b5
      - id: minute
        type: b6
      - id: sign
        type: b1
      - id: hour_deviation
        type: b5
      - id: minute_deviation
        type: b6

  ip_address:
    seq:
      - id: ip_address
        type: str
        size: 20
        encoding: UTF-8

  cdr:
    seq:
      - id: cdr_length
        type: u2
      - id: version
        type: release_version_identifier
      - id: data_record_format
        type: b3
      - id: ts_number
        type: b5
        enum: ts
      - id: release_identifier_extension
        type: release_identifier_extension
        if: version.release_identifier == 7
      - id: cdr_content
        size: cdr_length
    instances:
      cdr_encoding:
        value: 0 + data_record_format
        enum: encoding
    enums:
      encoding:
        1: ber
        2: unaligned_per
        3: aligned_per
        4: xml
      ts:
        0: number_32_005
        1: number_32_015
        2: number_32_205
        3: number_32_215
        4: number_32_225
        5: number_32_235
        6: number_32_250
        7: number_32_251
        9: number_32_260
        10: number_32_270
        11: number_32_271
        12: number_32_272
        13: number_32_273
        14: number_32_275
        15: number_32_274
        16: number_32_277
        17: number_32_296
        18: number_32_278
        19: number_32_253
        20: number_32_255
        21: number_32_254
        22: number_32_256
        23: number_28_201
        24: number_28_202
