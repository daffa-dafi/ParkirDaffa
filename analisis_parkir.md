# HW 2 — Computational Thinking dengan Dart



# Dokumen Analisis PARKIR LANGGANAN

## 1. Problem Statement
Pengguna parkir terdiri dari member bulanan dan non-member. Member bulanan parkir gratis, sedangkan non-member dikenakan tarif progresif berdasarkan lama parkir. Jika tiket hilang, pengguna (member maupun non-member) dikenakan denda Rp20.000.

## 2. Actor
Pengguna parkir (member bulanan atau non-member)

Pengguna merupakan pihak yang memarkir kendaraan dan membayar biaya parkir, sehingga berhubungan langsung dengan aturan tarif dan denda tiket hilang.

## 3. Input & Output

### Input
- Status pengguna ("member" atau "non-member")
- Lama parkir (jam)
- Status tiket (hilang atau tidak)

### Output
- Total biaya parkir
  - Rp0 jika member dan tiket tidak hilang
  - Tarif progresif jika non-member
  - Ditambah denda Rp20.000 jika tiket hilang

## 4. Functional Requirement

| Kode | Functional Requirement |
|------|------------------------|
| FR-01 | Sistem dapat memeriksa apakah pengguna adalah member bulanan. |
| FR-02 | Sistem dapat menghitung tarif progresif berdasarkan lama parkir. |
| FR-03 | Sistem dapat menghitung denda tiket hilang. |
| FR-04 | Sistem dapat memproses pembayaran parkir dan menampilkan total biaya. |

## 5. Business Rules

| Kode | Business Rule |
|------|---------------|
| BR-01 | Member bulanan parkir gratis. |
| BR-02 | Non-member dikenakan tarif progresif: jam pertama Rp3.000, jam kedua Rp2.000, jam ketiga dan seterusnya Rp1.000 per jam. |
| BR-03 | Tiket hilang dikenakan denda Rp20.000. |

> Catatan: angka tarif progresif pada BR-02 adalah asumsi, karena studi kasus hanya menyebutkan "tarif progresif".

## 6. Decomposition

```
parkirLangganan
│
├── prosesParkir
│   ├── cekMember               (BR-01)
│   ├── hitungTarifProgresif    (BR-02)
│   └── hitungDendaTiket        (BR-03)
```

## 7. Pattern Recognition

1. **Validasi status pengguna**
   Setiap transaksi parkir selalu diawali dengan pengecekan yang sama: apakah pengguna member atau bukan. Kalau member, tarif parkir 0. Kalau bukan, tarif dihitung dari lama parkir.

2. **Perhitungan tarif bertingkat**
   Tarif non-member selalu dihitung dengan pola yang sama: jam pertama paling mahal, lalu turun di jam kedua, lalu tetap Rp1.000 per jam untuk jam berikutnya.

3. **Perhitungan denda**
   Denda selalu dihitung dengan cara yang sama: kalau tiket hilang maka Rp20.000, kalau tidak maka 0. Aturan ini berlaku untuk semua jenis pengguna.

## 8. Abstraction

Data yang dibutuhkan untuk menyelesaikan masalah ini:

- **statusMember** → "member" atau "non-member".
- **lamaParkirJam** → lama kendaraan parkir dalam jam.
- **tiketHilang** → true jika tiket hilang, false jika tidak.

Data lain seperti plat nomor, jenis kendaraan, dan nama pengguna diabaikan karena tidak mempengaruhi aturan tarif dan denda.

## 9. Algorithm

### Flowchart

```
          START
            │
            ▼
  Input statusMember, lamaParkirJam, tiketHilang
            │
            ▼
  ┌──────────────────────┐  Ya
  │ statusMember =       ├──────► tarif = 0 ───────────────┐
  │ "member" ?           │                                 │
  └──────────┬───────────┘                                 │
         Tidak│                                            │
            ▼                                              │
  ┌──────────────────────┐  Ya                             │
  │ lamaParkirJam <= 0 ? ├──────► tarif = 0 ───────────────┤
  └──────────┬───────────┘                                 │
         Tidak│                                            │
            ▼                                              │
  ┌──────────────────────┐  Ya                             │
  │ lamaParkirJam = 1 ?  ├──────► tarif = 3000 ────────────┤
  └──────────┬───────────┘                                 │
         Tidak│                                            │
            ▼                                              │
  ┌──────────────────────┐  Ya                             │
  │ lamaParkirJam = 2 ?  ├──────► tarif = 3000 + 2000 ─────┤
  └──────────┬───────────┘                                 │
         Tidak│                                            │
            ▼                                              │
  tarif = 3000 + 2000                                      │
          + (lamaParkirJam - 2) x 1000                     │
            │                                              │
            ▼                                              │
         hitung denda ◄────────────────────────────────────┘
            │
            ▼
  ┌──────────────────────┐  Ya
  │ tiketHilang = true ? ├──────► denda = 20000 ──┐
  └──────────┬───────────┘                        │
         Tidak│                                   │
            ▼                                     │
        denda = 0                                 │
            │                                     │
            ▼                                     │
   total = tarif + denda ◄────────────────────────┘
            │
            ▼
      tampilkan total
            │
            ▼
           END
```

### Pseudocode

```
PROCEDURE cekMember(statusMember)
    RETURN statusMember = "member"               // BR-01
END PROCEDURE

PROCEDURE hitungTarifProgresif(lamaParkirJam)
    IF lamaParkirJam <= 0 THEN
        RETURN 0
    END IF
    IF lamaParkirJam = 1 THEN                    // BR-02
        RETURN 3000
    END IF
    IF lamaParkirJam = 2 THEN
        RETURN 3000 + 2000
    END IF
    RETURN 3000 + 2000 + (lamaParkirJam - 2) * 1000
END PROCEDURE

PROCEDURE hitungDendaTiket(tiketHilang)
    IF tiketHilang THEN                          // BR-03
        RETURN 20000
    END IF
    RETURN 0
END PROCEDURE

PROCEDURE prosesParkir(statusMember, lamaParkirJam, tiketHilang)
    IF cekMember(statusMember) THEN              // BR-01
        RETURN hitungDendaTiket(tiketHilang)
    END IF
    RETURN hitungTarifProgresif(lamaParkirJam) + hitungDendaTiket(tiketHilang)
END PROCEDURE
```

---

# Tabel Traceability

| Business Rule | Function | Diuji pada skenario |
|---------------|----------|---------------------|
| BR-01 Member bulanan gratis | `cekMember`, `prosesParkir` | Skenario 1 (member parkir 5 jam, hasil Rp0), Skenario 5 (member, tiket hilang, hanya denda) |
| BR-02 Non-member tarif progresif | `hitungTarifProgresif`, `prosesParkir` | Skenario 2 (1 jam = Rp3.000), Skenario 3 (4 jam = Rp7.000), Skenario 4 (2 jam = Rp5.000 + denda) |
| BR-03 Tiket hilang denda Rp20.000 | `hitungDendaTiket`, `prosesParkir` | Skenario 4 (non-member, tiket hilang = Rp25.000), Skenario 5 (member, tiket hilang = Rp20.000) |

Semua skenario sekaligus menguji kombinasi aturan: Skenario 4 menggabungkan BR-02 dan BR-03, Skenario 5 menggabungkan BR-01 dan BR-03.
