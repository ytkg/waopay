module WaopayCode
  class << self
    def encode(amount, user_id)
      unpack_str = "#{amount}->#{user_id}".unpack('H*').first
      "wao://#{unpack_str}"
    end

    def decode(str)
      pack_str = [str.delete('wao://')].pack('H*')
      amount, user_id = pack_str.split('->')
      [amount.to_i, user_id.to_i]
    end
  end
end
