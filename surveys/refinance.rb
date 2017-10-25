# encoding: UTF-8
# Question#is_mandatory is now false by default. The default_mandatory option allows you to set
#   is_mandatory for all questions in a survey.

survey "REFINANCE" do

  section "1 : ข้อมูลหน่วยงาน" do
    group "รายละเอียด" do
      q_0101 "ชื่อหน่วยงาน"
      a :string

      q_0102 "สังกัด"
      a :string

      q_0103 "จังหวัด", :pick => :one, :display_type => :dropdown
      a "กรุงเทพมหานคร"
      a "จังหวัดกระบี่ "
      a "จังหวัดกาญจนบุรี "
      a "จังหวัดกาฬสินธุ์ "
      a "จังหวัดกำแพงเพชร "
      a "จังหวัดขอนแก่น "
      a "จังหวัดจันทบุรี "
      a "จังหวัดฉะเชิงเทรา "
      a "จังหวัดชลบุรี "
      a "จังหวัดชัยนาท "
      a "จังหวัดชัยภูมิ "
      a "จังหวัดชุมพร "
      a "จังหวัดเชียงราย "
      a "จังหวัดเชียงใหม่ "
      a "จังหวัดตรัง "
      a "จังหวัดตราด "
      a "จังหวัดตาก "
      a "จังหวัดนครนายก "
      a "จังหวัดนครปฐม "
      a "จังหวัดนครพนม "
      a "จังหวัดนครราชสีมา "
      a "จังหวัดนครศรีธรรมราช "
      a "จังหวัดนครสวรรค์ "
      a "จังหวัดนนทบุรี "
      a "จังหวัดนราธิวาส "
      a "จังหวัดน่าน "
      a "จังหวัดบึงกาฬ "
      a "จังหวัดบุรีรัมย์ "
      a "จังหวัดปทุมธานี "
      a "จังหวัดประจวบคีรีขันธ์ "
      a "จังหวัดปราจีนบุรี "
      a "จังหวัดปัตตานี "
      a "จังหวัดพระนครศรีอยุธยา "
      a "จังหวัดพะเยา "
      a "จังหวัดพังงา "
      a "จังหวัดพัทลุง "
      a "จังหวัดพิจิตร "
      a "จังหวัดพิษณุโลก "
      a "จังหวัดเพชรบุรี "
      a "จังหวัดเพชรบูรณ์ "
      a "จังหวัดแพร่ "
      a "จังหวัดภูเก็ต "
      a "จังหวัดมหาสารคาม "
      a "จังหวัดมุกดาหาร "
      a "จังหวัดแม่ฮ่องสอน "
      a "จังหวัดยโสธร "
      a "จังหวัดยะลา "
      a "จังหวัดร้อยเอ็ด "
      a "จังหวัดระนอง "
      a "จังหวัดระยอง "
      a "จังหวัดราชบุรี "
      a "จังหวัดลพบุรี "
      a "จังหวัดลำปาง "
      a "จังหวัดลำพูน "
      a "จังหวัดเลย "
      a "จังหวัดศรีสะเกษ "
      a "จังหวัดสกลนคร "
      a "จังหวัดสงขลา "
      a "จังหวัดสตูล "
      a "จังหวัดสมุทรปราการ "
      a "จังหวัดสมุทรสงคราม "
      a "จังหวัดสมุทรสาคร "
      a "จังหวัดสระแก้ว "
      a "จังหวัดสระบุรี "
      a "จังหวัดสิงห์บุรี "
      a "จังหวัดสุโขทัย "
      a "จังหวัดสุพรรณบุรี "
      a "จังหวัดสุราษฎร์ธานี "
      a "จังหวัดสุรินทร์ "
      a "จังหวัดหนองคาย "
      a "จังหวัดหนองบัวลำภู "
      a "จังหวัดอ่างทอง "
      a "จังหวัดอำนาจเจริญ "
      a "จังหวัดอุดรธานี "
      a "จังหวัดอุตรดิตถ์ "
      a "จังหวัดอุทัยธานี "
      a "จังหวัดอุบลราชธานี "
    end
  end

  section "2 : ข้อมูลทั่วไป" do
    q_0201 "เพศ",:pick => :one, :display_type => :inline
    a "ชาย"
    a "หญิง"
    a "เพศทางเลือก"

    q_0202 "อายุ"
    a "|ปี", :integer

    q_0203 "สถานภาพสมรส", :pick => :one, :display_type => :dropdown
    a_1 "โสด"
    a_2 "แต่งงานและอยู่ร่วมกัน"
    a_3 "แต่งงานแต่ไม่ได้อยู่ด้วยกัน"
    a_4 "อยู่ด้วยกันโดยไม่ได้แต่งงาน"
    a_5 "หม้าย"
    a_6 "หย่า/แยกทาง/เลิกกัน"

    q_0204 "ท่านปฏิบัติงานในระดับแผนกใด", :pick => :one, :display_type => :dropdown
    a :string

    q_0205 "สถานภาพการจ้างงาน", :pick => :one, :display_type => :dropdown
    a_1 "ประจำ"
    a_2 "ตามสัญญาจ้าง"
    a_3 "รายวัน"
    a_4 "บางช่วงเวลา"
    a_5 "ตามผลงาน"
    a_6 "จ้างเหมา"

    q_0206 "ระยะเวลาที่ท่านทำงานในองค์กรปัจจุบัน รวมทั้งหมด", :pick => :one
    a_1 "ไม่ถึงปี"
    a_2 "ระหว่าง 1-2 ปี"
    a_3 "ระหว่าง 3-5 ปี"
    a_4 "ระหว่าง 6-9 ปี"

    q_0207 "ท่านมีรายได้ต่อเดือน โดยประมาณเดือนละเท่าใด (รายได้+เงินเดือน+ค่าตอบแทนอื่นๆ)", :pick => :one
    a_1 "น้อยกว่า 10,000 บาท"
    a_2 "10,001-20,000 บาท"
    a_3 "20,001-30,000 บาท"
    a_4 "30,001-40,000 บาท"
    a_5 "40,001-50,000 บาท"
    a_6 "50,001-100,000 บาท"
    a_7 "มากกว่า 100,000 บาท"

  end

  section "3 : Financial" do

  label "Happy Money / สุขภาพเงินดี"

    q_0301 "ท่านรู้สึกว่า การผ่อนชำระหนี้สินต่างๆ โดยรวมของท่านในปัจจุบันเป็นภาระ หรือไม่", :pick => :one
    a_1 "เป็นภาระหนักที่สุด"
    a_2 "เป็นภาระหนักมาก"
    a_3 "เป็นภาระปานกลาง"
    a_4 "เป็นภาระน้อย"
    a_5 "ไม่เป็นภาระ/ไม่ได้ผ่อนชำระ/ไม่มีหนี้สิน"

    q_0302 "ท่านผ่อนชำระหนี้ตามกำหนดเวลาทุกครั้งหรือไม่", :pick => :one
    a_1 "ไม่ตรงเวลาทุกครั้ง"
    a_2 "ไม่ตรงเวลาบ่อยครั้ง"
    a_3 "ตรงเวลาบ้างบางครั้ง"
    a_4 "ตรงเวลาเกือบทุกครั้ง"
    a_5 "ตรงเวลาทุกครั้ง/ไม่ได้ผ่อนชำระ/ไม่มีหนี้สิน"

    q_0303 "โดยรวมแล้ว ท่านมีเงินเก็บออมในแต่ละเดือนหรือไม่", :pick => :one
    a_1 "ไม่มี/มีน้อยที่สุด"
    a_2 "มี/เก็บออมเพียงเล็กน้อย"
    a_3 "มี/เก็บออมปานกลาง"
    a_4 "มี/เก็บออมมาก"
    a_5 "มี/เก็บออมมากที่สุด"

    q_0304 "โดยรวมแล้ว ค่าตอบแทนที่ท่านได้รับทั้งหมดในแต่ละเดือนเป็นอย่างไร เมื่อเปรียบเทียบกับรายจ่ายทั้งหมดในแต่ละเดือน", :pick => :one
    a_1 "รายจ่ายเกินกว่ารายได้มาก"
    a_2 "รายจ่ายเกินกว่าเล็กน้อย"
    a_3 "รายจ่ายพอๆ"
    a_4 "รายจ่ายน้อยกว่ารายได้"
    a_5 "รายจ่ายน้อยกว่ารายได้มาก"

  end
end


