// member bulanan parkirnya gratis
bool cekMember(String statusMember) {
  return statusMember == "member";
}

// jam pertama Rp3.000, jam kedua Rp2.000 per jam, jam ketiga dst Rp1.000 per jam
int hitungTarifProgresif(int lamaParkirJam) {
  if (lamaParkirJam <= 0) {
    return 0;
  }
  if (lamaParkirJam == 1) {
    return 3000;
  }
  if (lamaParkirJam == 2) {
    return 3000 + 2000;
  }
  return 3000 + 2000 + (lamaParkirJam - 2) * 1000;
}

// denda tiket hilang Rp20.000
int hitungDendaTiket(bool tiketHilang) {
  return tiketHilang ? 20000 : 0;
}

// proses bayar parkir, hasilnya berupa total biaya
int prosesParkir(String statusMember, int lamaParkirJam, bool tiketHilang) {
  // member gratis, tapi kalau tiket hilang tetap kena denda
  if (cekMember(statusMember)) {
    return hitungDendaTiket(tiketHilang);
  }
  return hitungTarifProgresif(lamaParkirJam) + hitungDendaTiket(tiketHilang);
}

void main() {
  // Skenario 1 member bulanan parkir 5 jam, gratis
  print("Biaya: Rp${prosesParkir("member", 5, false)}");
  // Skenario 2 non-member parkir 1 jam
  print("Biaya: Rp${prosesParkir("non-member", 1, false)}");
  // Skenario 3 non-member parkir 4 jam, tarif progresif
  print("Biaya: Rp${prosesParkir("non-member", 4, false)}");
  // Skenario 4 non-member parkir 2 jam tapi tiket hilang, tarif + denda 20000
  print("Biaya: Rp${prosesParkir("non-member", 2, true)}");
  // Skenario 5 member tapi tiket hilang, hanya bayar denda 20000
  print("Biaya: Rp${prosesParkir("member", 3, true)}");
}