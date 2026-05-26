fn reverse(string) {
    if string.len == 1 {
        return string;
    } else {
        return reverse(string.sub_string(1)) + string[0];
    }
}

fn hexToNum(hex) {
    let base = 16;
    let hexValue = #{
        "0": 0,
        "1": 1,
        "2": 2,
        "3": 3,
        "4": 4,
        "5": 5,
        "6": 6,
        "7": 7,
        "8": 8,
        "9": 9,
        "a": 10,
        "b": 11,
        "c": 12,
        "d": 13,
        "e": 14,
        "f": 15,
    };

    let power = 0;
    let num = 0;
    for char in reverse(hex).chars() {
        num += hexValue[char.to_string()] * (base**power);
        power += 1;
    }

    return num;
}

let hex = params[0];
if hex.len == 3 {
    hex = "" + hex[0] + hex[0] + hex[1] + hex[1] + hex[2] + hex[2];
}
if hex.len != 6 {
    throw "Input length must be 3 or 6"
}

let r = hexToNum(hex.sub_string(0, 2));
let g = hexToNum(hex.sub_string(2, 2));
let b = hexToNum(hex.sub_string(4, 2));

let rf = r.to_float() / 255.0;
let gf = g.to_float() / 255.0;
let bf = b.to_float() / 255.0;

"<dict>\n\t\t<key>Alpha Component</key>\n\t\t<real>1</real>\n\t\t<key>Blue Component</key>\n\t\t<real>" + bf + "</real>\n\t\t<key>Color Space</key>\n\t\t<string>sRGB</string>\n\t\t<key>Green Component</key>\n\t\t<real>" + gf + "</real>\n\t\t<key>Red Component</key>\n\t\t<real>" + rf + "</real>\n\t</dict>"
