/**
 *
 * @param {integer} barangId what you search for
 * @param {integer} jumlah is amount of cart / item
 * @param {string} walkInCutomer is string identify current user in queue
 * @param {integer} gudangId default is null, but if you want to make sure produk came from, use gudangId atau depotId
 * @returns {object}
 */
exports.makeReadableForHuman = async (barangId, walkInCustomer = null, jumlah, gudangId = null, cart = null) => {
  let cart_item = walkInCustomer == null ? cart : await Cart.getSingleCart(barangId, walkInCustomer);
  let daftar_harga = await Items.getSellingPrice(barangId, gudangId);

  let qty = jumlah;

  let isi_jual_level_1 = daftar_harga?.isi_jual_level_1;
  let isi_jual_level_2 = daftar_harga?.isi_jual_level_2;
  let isi_jual_level_3 = daftar_harga?.isi_jual_level_3;
  let isi_jual_level_4 = daftar_harga?.isi_jual_level_4;

  let harga_jual_level_1 = daftar_harga?.harga_jual_level_1;
  let harga_jual_level_2 = daftar_harga?.harga_jual_level_2;
  let harga_jual_level_3 = daftar_harga?.harga_jual_level_3;
  let harga_jual_level_4 = daftar_harga?.harga_jual_level_4;

  let satuan_jual_level_1 = daftar_harga?.satuan_jual_level_1;
  let satuan_jual_level_2 = daftar_harga?.satuan_jual_level_2;
  let satuan_jual_level_3 = daftar_harga?.satuan_jual_level_3;
  let satuan_jual_level_4 = daftar_harga?.satuan_jual_level_4;

  let notes = {
    isi_jual: this.filteredObj({
      isi_jual_level_1,
      isi_jual_level_2,
      isi_jual_level_3,
      isi_jual_level_4,
    }),
    harga_jual: this.filteredObj({
      harga_jual_level_1,
      harga_jual_level_2,
      harga_jual_level_3,
      harga_jual_level_4,
    }),
  };

  var sub_total = 0,
    hjlv_1 = 0,
    hjlv_2 = 0,
    hjlv_3 = 0,
    hjlv_4 = 0,
    jenis_harga = "harga_jual_level_1",
    satuan_jual_nama = isi_jual_level_1 + " " + (await Units.getUnitName(satuan_jual_level_1));

  let total_baris = Object.keys(notes.isi_jual).length < 1 ? null : Object.keys(notes.isi_jual).length;

  var result = {};
  var satuan_array = [];
  if (total_baris != null) {
    if (total_baris === 1) {
      hjlv_1 = cart_item == null || cart_item?.nego_harga_level_1 == 0 ? notes.harga_jual.harga_jual_level_1 : cart_item?.nego_harga_level_1;
      sub_total = hjlv_1 * qty;
      jenis_harga = "harga_jual_level_1";
      satuan_jual_nama = `${qty} ${await Units.getUnitName(satuan_jual_level_1)}`;
      satuan_array.push({
        nama_unit: await Units.getUnitName(satuan_jual_level_1),
        unit_id: satuan_jual_level_1,
        level: "harga_jual_level_1",
      });
    } else if (total_baris === 2) {
      hjlv_1 = cart_item == null || cart_item?.nego_harga_level_1 == 0 ? notes.harga_jual.harga_jual_level_1 : cart_item?.nego_harga_level_1;
      hjlv_2 = cart_item == null || cart_item?.nego_harga_level_2 == 0 ? notes.harga_jual.harga_jual_level_2 : cart_item?.nego_harga_level_2;

      if (qty >= notes.isi_jual.isi_jual_level_1 && qty < notes.isi_jual.isi_jual_level_2) {
        sub_total = hjlv_1 * qty;
        jenis_harga = "harga_jual_level_1";
        satuan_jual_nama = `${qty} ${await Units.getUnitName(satuan_jual_level_1)}`;
        satuan_array.push({
          nama_unit: await Units.getUnitName(satuan_jual_level_1),
          unit_id: satuan_jual_level_1,
          level: "harga_jual_level_1",
        });
      } else if (qty >= notes.isi_jual.isi_jual_level_2) {
        var pack = Math.floor(qty / isi_jual_level_2);
        var pcs = qty % isi_jual_level_2;

        if (pack != 0 && pcs == 0) {
          sub_total = hjlv_2 * pack;
          jenis_harga = "harga_jual_level_2";
          satuan_jual_nama = `${pack} ${await Units.getUnitName(satuan_jual_level_2)}`;
          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_2),
            unit_id: satuan_jual_level_2,
            level: "harga_jual_level_2",
          });
        } else if (pack != 0 && pcs != 0) {
          sub_total = hjlv_2 * pack + hjlv_1 * pcs;
          jenis_harga = "harga_jual_level_2";
          satuan_jual_nama = `${pack} ${await Units.getUnitName(satuan_jual_level_2)}, ${pcs} ${await Units.getUnitName(satuan_jual_level_1)}`;
          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_1),
            unit_id: satuan_jual_level_1,
            level: "harga_jual_level_1",
          });
          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_2),
            unit_id: satuan_jual_level_2,
            level: "harga_jual_level_2",
          });
        }
      }
    } else if (total_baris === 3) {
      hjlv_1 = cart_item == null || cart_item?.nego_harga_level_1 == 0 ? notes.harga_jual.harga_jual_level_1 : cart_item?.nego_harga_level_1;
      hjlv_2 = cart_item == null || cart_item?.nego_harga_level_2 == 0 ? notes.harga_jual.harga_jual_level_2 : cart_item?.nego_harga_level_2;
      hjlv_3 = cart_item == null || cart_item?.nego_harga_level_3 == 0 ? notes.harga_jual.harga_jual_level_3 : cart_item?.nego_harga_level_3;

      if (qty >= notes.isi_jual.isi_jual_level_1 && qty < notes.isi_jual.isi_jual_level_2) {
        sub_total = hjlv_1 * qty;
        jenis_harga = "harga_jual_level_1";
        satuan_jual_nama = `${qty} ${await Units.getUnitName(satuan_jual_level_1)}`;
        satuan_array.push({
          nama_unit: await Units.getUnitName(satuan_jual_level_1),
          unit_id: satuan_jual_level_1,
          level: "harga_jual_level_1",
        });
      } else if (qty >= notes.isi_jual.isi_jual_level_2 && qty < notes.isi_jual.isi_jual_level_3) {
        var pack = Math.floor(qty / isi_jual_level_2);
        var pcs = qty % isi_jual_level_2;

        if (pack != 0 && pcs == 0) {
          sub_total = hjlv_2 * pack;
          jenis_harga = "harga_jual_level_2";
          satuan_jual_nama = `${pack} ${await Units.getUnitName(satuan_jual_level_2)}`;
          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_2),
            unit_id: satuan_jual_level_2,
            level: "harga_jual_level_2",
          });
          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_1),
            unit_id: satuan_jual_level_1,
            level: "harga_jual_level_1",
          });
        } else if (pack != 0 && pcs != 0 && pcs < isi_jual_level_2) {
          sub_total = hjlv_2 * pack + hjlv_1 * pcs;
          jenis_harga = "harga_jual_level_2";
          satuan_jual_nama = `${pack} ${await Units.getUnitName(satuan_jual_level_2)}, ${pcs} ${await Units.getUnitName(satuan_jual_level_1)}`;
          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_2),
            unit_id: satuan_jual_level_2,
            level: "harga_jual_level_2",
          });
          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_1),
            unit_id: satuan_jual_level_1,
            level: "harga_jual_level_1",
          });
        }
      } else if (qty >= notes.isi_jual.isi_jual_level_3) {
        var pack = Math.floor(qty / isi_jual_level_3);
        var pcs = qty % isi_jual_level_3;

        if (pack != 0 && pcs == 0) {
          sub_total = hjlv_3 * pack;
          jenis_harga = "harga_jual_level_3";
          satuan_jual_nama = `${pack} ${await Units.getUnitName(satuan_jual_level_3)}`;
          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_3),
            unit_id: satuan_jual_level_3,
            level: "harga_jual_level_3",
          });
        } else if (pack != 0 && pcs != 0 && pcs < isi_jual_level_2) {
          sub_total = hjlv_3 * pack + hjlv_1 * pcs;
          jenis_harga = "harga_jual_level_3";
          satuan_jual_nama = `${pack} ${await Units.getUnitName(satuan_jual_level_3)}, ${pcs} ${await Units.getUnitName(satuan_jual_level_1)}`;
          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_1),
            unit_id: satuan_jual_level_1,
            level: "harga_jual_level_1",
          });
          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_3),
            unit_id: satuan_jual_level_3,
            level: "harga_jual_level_3",
          });
        } else if (pack != 0 && pcs != 0 && pcs >= isi_jual_level_2) {
          var pack_1 = Math.floor(pcs / isi_jual_level_2);
          var pcs_1 = pcs % isi_jual_level_2;

          if (pack_1 != 0 && pcs_1 == 0) {
            sub_total = hjlv_3 * pack + hjlv_2 * pack_1;
            jenis_harga = "harga_jual_level_3";
            satuan_jual_nama = `${pack} ${await Units.getUnitName(satuan_jual_level_3)}, ${pack_1} ${await Units.getUnitName(satuan_jual_level_2)}`;

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_1),
              unit_id: satuan_jual_level_1,
              level: "harga_jual_level_1",
            });
            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_2),
              unit_id: satuan_jual_level_2,
              level: "harga_jual_level_2",
            });
            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_3),
              unit_id: satuan_jual_level_3,
              level: "harga_jual_level_3",
            });
          } else {
            sub_total = hjlv_3 * pack + hjlv_2 * pack_1 + hjlv_1 * pcs_1;
            jenis_harga = "harga_jual_level_3";
            satuan_jual_nama = `${pack} ${await Units.getUnitName(satuan_jual_level_3)}, ${pack_1} ${await Units.getUnitName(satuan_jual_level_2)}, ${pcs_1} ${await Units.getUnitName(satuan_jual_level_1)}`;

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_1),
              unit_id: satuan_jual_level_1,
              level: "harga_jual_level_1",
            });
            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_2),
              unit_id: satuan_jual_level_2,
              level: "harga_jual_level_2",
            });
            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_3),
              unit_id: satuan_jual_level_3,
              level: "harga_jual_level_3",
            });
          }
        }
      }
    } else if (total_baris === 4) {
      hjlv_1 = cart_item == null || cart_item?.nego_harga_level_1 == 0 ? notes.harga_jual.harga_jual_level_1 : cart_item?.nego_harga_level_1;
      hjlv_2 = cart_item == null || cart_item?.nego_harga_level_2 == 0 ? notes.harga_jual.harga_jual_level_2 : cart_item?.nego_harga_level_2;
      hjlv_3 = cart_item == null || cart_item?.nego_harga_level_3 == 0 ? notes.harga_jual.harga_jual_level_3 : cart_item?.nego_harga_level_3;
      hjlv_4 = cart_item == null || cart_item?.nego_harga_level_4 == 0 ? notes.harga_jual.harga_jual_level_4 : cart_item?.nego_harga_level_4;

      if (qty >= notes.isi_jual.isi_jual_level_1 && qty < notes.isi_jual.isi_jual_level_2) {
        sub_total = hjlv_1 * qty;
        jenis_harga = "harga_jual_level_1";
        satuan_jual_nama = `${qty} ${await Units.getUnitName(satuan_jual_level_1)}`;

        satuan_array.push({
          nama_unit: await Units.getUnitName(satuan_jual_level_1),
          unit_id: satuan_jual_level_1,
          level: "harga_jual_level_1",
        });
      } else if (qty >= notes.isi_jual.isi_jual_level_2 && qty < notes.isi_jual.isi_jual_level_3) {
        var pack = Math.floor(qty / isi_jual_level_2);
        var pcs = qty % isi_jual_level_2;

        if (pack != 0 && pcs == 0) {
          sub_total = hjlv_2 * pack;
          jenis_harga = "harga_jual_level_2";
          satuan_jual_nama = `${pack} ${await Units.getUnitName(satuan_jual_level_2)}`;

          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_1),
            unit_id: satuan_jual_level_1,
            level: "harga_jual_level_1",
          });
        } else if (pack != 0 && pcs != 0 && pcs < isi_jual_level_2) {
          sub_total = hjlv_2 * pack + hjlv_1 * pcs;
          jenis_harga = "harga_jual_level_2";
          satuan_jual_nama = `${pack} ${await Units.getUnitName(satuan_jual_level_2)}, ${pcs} ${await Units.getUnitName(satuan_jual_level_1)}`;

          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_1),
            unit_id: satuan_jual_level_1,
            level: "harga_jual_level_1",
          });
          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_2),
            unit_id: satuan_jual_level_2,
            level: "harga_jual_level_2",
          });
        }
      } else if (qty >= notes.isi_jual.isi_jual_level_3 && qty < notes.isi_jual.isi_jual_level_4) {
        var pack = Math.floor(qty / isi_jual_level_3);
        var pcs = qty % isi_jual_level_3;

        if (pack != 0 && pcs == 0) {
          sub_total = hjlv_3 * pack;
          jenis_harga = "harga_jual_level_3";
          satuan_jual_nama = `${pack} ${await Units.getUnitName(satuan_jual_level_3)}`;
          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_3),
            unit_id: satuan_jual_level_3,
            level: "harga_jual_level_3",
          });
        } else if (pack != 0 && pcs != 0 && pcs < isi_jual_level_2) {
          sub_total = hjlv_3 * pack + hjlv_1 * pcs;
          jenis_harga = "harga_jual_level_3";
          satuan_jual_nama = `${pack} ${await Units.getUnitName(satuan_jual_level_3)}, ${pcs} ${await Units.getUnitName(satuan_jual_level_1)}`;

          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_3),
            unit_id: satuan_jual_level_3,
            level: "harga_jual_level_3",
          });
          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_1),
            unit_id: satuan_jual_level_1,
            level: "harga_jual_level_1",
          });
        } else if (pack != 0 && pcs != 0 && pcs >= isi_jual_level_2) {
          var pack_1 = Math.floor(pcs / isi_jual_level_2);
          var pcs_1 = pcs % isi_jual_level_2;

          if (pack_1 != 0 && pcs_1 == 0) {
            sub_total = hjlv_3 * pack + hjlv_2 * pack_1;
            jenis_harga = "harga_jual_level_3";
            satuan_jual_nama = `${pack} ${await Units.getUnitName(satuan_jual_level_3)}, ${pack_1} ${await Units.getUnitName(satuan_jual_level_2)}`;

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_2),
              unit_id: satuan_jual_level_2,
              level: "harga_jual_level_2",
            });
            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_3),
              unit_id: satuan_jual_level_3,
              level: "harga_jual_level_3",
            });
          } else {
            sub_total = hjlv_3 * pack + hjlv_2 * pack_1 + hjlv_1 * pcs_1;
            jenis_harga = "harga_jual_level_3";
            satuan_jual_nama = `${pack} ${await Units.getUnitName(satuan_jual_level_3)}, ${pack_1} ${await Units.getUnitName(satuan_jual_level_2)}, ${pcs_1} ${await Units.getUnitName(satuan_jual_level_1)}`;

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_1),
              unit_id: satuan_jual_level_1,
              level: "harga_jual_level_1",
            });
            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_2),
              unit_id: satuan_jual_level_2,
              level: "harga_jual_level_2",
            });
            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_3),
              unit_id: satuan_jual_level_3,
              level: "harga_jual_level_3",
            });
          }
        }
      } else if (qty >= notes.isi_jual.isi_jual_level_4) {
        hjlv_1 = cart_item?.nego_harga_level_1 == 0 ? notes.harga_jual.harga_jual_level_1 : cart_item?.nego_harga_level_1;
        hjlv_2 = cart_item?.nego_harga_level_2 == 0 ? notes.harga_jual.harga_jual_level_2 : cart_item?.nego_harga_level_2;
        hjlv_3 = cart_item?.nego_harga_level_3 == 0 ? notes.harga_jual.harga_jual_level_3 : cart_item?.nego_harga_level_3;
        hjlv_4 = cart_item?.nego_harga_level_4 == 0 ? notes.harga_jual.harga_jual_level_4 : cart_item?.nego_harga_level_4;

        var pack = Math.floor(qty / isi_jual_level_4);
        var pcs = qty % isi_jual_level_4;

        if (pack != 0 && pcs == 0) {
          sub_total = hjlv_4 * pack;
          jenis_harga = "harga_jual_level_4";
          satuan_jual_nama = `${pack} ${await Units.getUnitName(satuan_jual_level_4)}`;

          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_4),
            unit_id: satuan_jual_level_4,
            level: "harga_jual_level_4",
          });
        } else if (pack != 0 && pcs != 0 && pcs < isi_jual_level_2 && pcs < isi_jual_level_3) {
          var pack_1 = Math.floor(pcs / isi_jual_level_2);
          var pcs_1 = pcs % isi_jual_level_2;

          if (pack_1 != 0 && pcs_1 == 0) {
            sub_total = hjlv_4 * pack + hjlv_2 * pack_1;
            jenis_harga = "harga_jual_level_4";
            satuan_jual_nama = `${pack} ${await Units.getUnitName(satuan_jual_level_4)}, ${pack_1} ${await Units.getUnitName(satuan_jual_level_2)}`;

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_4),
              unit_id: satuan_jual_level_4,
              level: "harga_jual_level_4",
            });

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_2),
              unit_id: satuan_jual_level_2,
              level: "harga_jual_level_2",
            });
          } else if (pack_1 == 0 && pcs_1 != 0) {
            sub_total = hjlv_4 * pack + hjlv_1 * pcs_1;
            jenis_harga = "harga_jual_level_4";
            satuan_jual_nama = `${pack} ${await Units.getUnitName(satuan_jual_level_4)}, ${pcs} ${await Units.getUnitName(satuan_jual_level_1)}`;

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_4),
              unit_id: satuan_jual_level_4,
              level: "harga_jual_level_4",
            });

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_1),
              unit_id: satuan_jual_level_1,
              level: "harga_jual_level_1",
            });
          } else if (pack_1 != 0 && pcs_1 != 0) {
            sub_total = hjlv_4 * pack + notes["harga_jual"]["harga_jual_level_2"] * pack_1 + hjlv_1 * pcs_1;
            jenis_harga = "harga_jual_level_4";
            satuan_jual_nama = `${pack} ${await Units.getUnitName(satuan_jual_level_4)}, ${pack_1} ${await Units.getUnitName(satuan_jual_level_2)}, ${pcs} ${await Units.getUnitName(satuan_jual_level_1)}`;

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_4),
              unit_id: satuan_jual_level_4,
              level: "harga_jual_level_4",
            });

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_2),
              unit_id: satuan_jual_level_2,
              level: "harga_jual_level_2",
            });

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_1),
              unit_id: satuan_jual_level_1,
              level: "harga_jual_level_1",
            });
          }
        } else if (pack != 0 && pcs != 0 && pcs >= isi_jual_level_2 && pcs < isi_jual_level_3) {
          var pack_1 = Math.floor(pcs / isi_jual_level_2);
          var pcs_1 = pcs % isi_jual_level_2;

          if (pack_1 != 0 && pcs_1 == 0) {
            sub_total = hjlv_4 * pack + hjlv_2 * pack_1;
            jenis_harga = "harga_jual_level_4";
            satuan_jual_nama = `${pack} ${await Units.getUnitName(satuan_jual_level_4)}, ${pack_1} ${await Units.getUnitName(satuan_jual_level_2)}`;

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_4),
              unit_id: satuan_jual_level_4,
              level: "harga_jual_level_4",
            });

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_2),
              unit_id: satuan_jual_level_2,
              level: "harga_jual_level_2",
            });
          } else if (pack_1 != 0 && pcs_1 != 0) {
            sub_total = hjlv_4 * pack + hjlv_2 * pack_1 + hjlv_1 * pcs_1;
            jenis_harga = "harga_jual_level_4";
            satuan_jual_nama = `${pack} ${await Units.getUnitName(satuan_jual_level_4)}, ${pack_1} ${await Units.getUnitName(satuan_jual_level_2)}, ${pcs} ${await Units.getUnitName(satuan_jual_level_1)}`;

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_4),
              unit_id: satuan_jual_level_4,
              level: "harga_jual_level_4",
            });

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_2),
              unit_id: satuan_jual_level_2,
              level: "harga_jual_level_2",
            });

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_1),
              unit_id: satuan_jual_level_1,
              level: "harga_jual_level_1",
            });
          }
        } else if (pack != 0 && pcs != 0 && pcs >= isi_jual_level_3 && pcs < isi_jual_level_4) {
          var pack_1 = Math.floor(pcs / isi_jual_level_4);
          var pcs_1 = pcs % isi_jual_level_4;

          var pack_2 = Math.floor(pcs_1 / isi_jual_level_3);
          var pcs_2 = pcs_1 % isi_jual_level_3;

          var pack_3 = Math.floor(pcs_2 / isi_jual_level_2);
          var pcs_3 = pcs_2 % isi_jual_level_2;

          var pack_4 = Math.floor(pcs_3 / isi_jual_level_1);
          var pcs_4 = pcs_3 % isi_jual_level_1;

          if (pack != 0 && pack_2 == 0 && pack_3 == 0 && pack_4 == 0) {
            sub_total = hjlv_4 * pack;
            jenis_harga = "harga_jual_level_4";
            satuan_jual_nama = `${pack} ${await Units.getUnitName(satuan_jual_level_4)}`;

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_4),
              unit_id: satuan_jual_level_4,
              level: "harga_jual_level_4",
            });
          } else if (pack != 0 && pack_2 != 0 && pack_3 == 0 && pack_4 == 0) {
            sub_total = hjlv_4 * pack + hjlv_3 * pack_2;
            jenis_harga = "harga_jual_level_4";
            satuan_jual_nama = `${pack} ${await Units.getUnitName(satuan_jual_level_4)}, ${pack_2} ${await Units.getUnitName(satuan_jual_level_3)}`;

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_4),
              unit_id: satuan_jual_level_4,
              level: "harga_jual_level_4",
            });

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_2),
              unit_id: satuan_jual_level_2,
              level: "harga_jual_level_2",
            });
          } else if (pack != 0 && pack_2 != 0 && pack_3 != 0 && pack_4 == 0) {
            sub_total = hjlv_4 * pack + hjlv_3 * pack_2 + hjlv_2 * pack_3;
            jenis_harga = "harga_jual_level_4";
            satuan_jual_nama = `${pack} ${await Units.getUnitName(satuan_jual_level_4)}, ${pack_2} ${await Units.getUnitName(satuan_jual_level_3)}, ${pack_3} ${await Units.getUnitName(satuan_jual_level_2)}`;

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_4),
              unit_id: satuan_jual_level_4,
              level: "harga_jual_level_4",
            });

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_3),
              unit_id: satuan_jual_level_3,
              level: "harga_jual_level_3",
            });

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_2),
              unit_id: satuan_jual_level_2,
              level: "harga_jual_level_2",
            });
          } else if (pack != 0 && pack_2 != 0 && pack_3 != 0 && pack_4 != 0) {
            sub_total = hjlv_4 * pack + hjlv_3 * pack_2 + hjlv_2 * pack_3 + hjlv_1 * pack_4;
            jenis_harga = "harga_jual_level_4";
            satuan_jual_nama = `${pack} ${await Units.getUnitName(satuan_jual_level_4)}, ${pack_2} ${await Units.getUnitName(satuan_jual_level_3)}, ${pack_3} ${await Units.getUnitName(
              satuan_jual_level_2
            )}, ${pack_4} ${await Units.getUnitName(satuan_jual_level_1)}`;

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_4),
              unit_id: satuan_jual_level_4,
              level: "harga_jual_level_4",
            });

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_3),
              unit_id: satuan_jual_level_3,
              level: "harga_jual_level_3",
            });

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_2),
              unit_id: satuan_jual_level_2,
              level: "harga_jual_level_2",
            });

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_1),
              unit_id: satuan_jual_level_1,
              level: "harga_jual_level_1",
            });
          } else if (pack != 0 && pack_2 != 0 && pack_3 == 0 && pack_4 != 0) {
            sub_total = hjlv_4 * pack + hjlv_3 * pack_2 + hjlv_1 * pack_4;
            jenis_harga = "harga_jual_level_4";
            satuan_jual_nama = `${pack} ${await Units.getUnitName(satuan_jual_level_4)}, ${pack_2} ${await Units.getUnitName(satuan_jual_level_3)}, ${pack_4} ${await Units.getUnitName(satuan_jual_level_1)}`;

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_3),
              unit_id: satuan_jual_level_3,
              level: "harga_jual_level_3",
            });

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_3),
              unit_id: satuan_jual_level_3,
              level: "harga_jual_level_3",
            });

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_1),
              unit_id: satuan_jual_level_1,
              level: "harga_jual_level_1",
            });
          }
        }
      }
    }

    result = {
      satuan_jual_nama,
      sub_total,
      jenis_harga,
      jumlah,
      hjlv_1,
      hjlv_2,
      hjlv_3,
      hjlv_4,
      satuan_array,
      notes,
    };
  } else {
    result = {};
  }
  return result;
};

/**
 * @param {integer} barangId what you search for
 * @param {string} walkInCustomer is a unique identifier for your cart
 * @param {integer} jumlah is amount of cart / item
 * @param {integer} gudangId default is null, but if you wanti to make sure produk came from, use gudangId atau depotId
 * @returns {object}
 */
exports.negoReadableForHuman = async (
  barangId,
  walkInCustomer,
  jumlah,
  gudangId = null
) => {
  let cart_item = await Cart.getSingleCart(barangId, walkInCustomer)
  let cart_id = cart_item.keranjang_belanja_id
  let daftar_harga = await Items.getSellingPrice(barangId, gudangId)

  let qty = jumlah

  let isi_jual_level_1 = daftar_harga.isi_jual_level_1
  let isi_jual_level_2 = daftar_harga.isi_jual_level_2
  let isi_jual_level_3 = daftar_harga.isi_jual_level_3
  let isi_jual_level_4 = daftar_harga.isi_jual_level_4

  let harga_jual_level_1 = daftar_harga.harga_jual_level_1
  let harga_jual_level_2 = daftar_harga.harga_jual_level_2
  let harga_jual_level_3 = daftar_harga.harga_jual_level_3
  let harga_jual_level_4 = daftar_harga.harga_jual_level_4

  let satuan_jual_level_1 = daftar_harga.satuan_jual_level_1
  let satuan_jual_level_2 = daftar_harga.satuan_jual_level_2
  let satuan_jual_level_3 = daftar_harga.satuan_jual_level_3
  let satuan_jual_level_4 = daftar_harga.satuan_jual_level_4

  let notes = {
    isi_jual: this.filteredObj({
      isi_jual_level_1,
      isi_jual_level_2,
      isi_jual_level_3,
      isi_jual_level_4,
    }),
    harga_jual: this.filteredObj({
      harga_jual_level_1,
      harga_jual_level_2,
      harga_jual_level_3,
      harga_jual_level_4,
    }),
  }

  var sub_total = 0,
    hjlv_1 = 0,
    hjlv_2 = 0,
    hjlv_3 = 0,
    hjlv_4 = 0,
    jenis_harga = 'harga_jual_level_1',
    satuan_jual_nama =
      isi_jual_level_1 + ' ' + Units.getUnitName(satuan_jual_level_1)

  let total_baris =
    Object.keys(notes.isi_jual).length < 1
      ? null
      : Object.keys(notes.isi_jual).length

  var result = {}
  if (total_baris != null) {
    var satuan_array = []
    if (total_baris === 1) {
      hjlv_1 =
        cart_item?.nego_harga_level_1 == null
          ? notes.harga_jual.harga_jual_level_1
          : cart_item?.nego_harga_level_1
      sub_total = hjlv_1 * qty
      jenis_harga = 'harga_jual_level_1'
      satuan_jual_nama = `${qty} ${await Units.getUnitName(
        satuan_jual_level_1
      )}`
      satuan_array.push({
        nama_unit: await Units.getUnitName(satuan_jual_level_1),
        unit_id: satuan_jual_level_1,
        level: 'harga_jual_level_1',
      })
    } else if (total_baris === 2) {
      hjlv_1 =
        cart_item?.nego_harga_level_1 == null
          ? notes.harga_jual.harga_jual_level_1
          : cart_item?.nego_harga_level_1
      hjlv_2 =
        cart_item?.nego_harga_level_2 == null
          ? notes.harga_jual.harga_jual_level_2
          : cart_item?.nego_harga_level_2

      if (
        qty >= notes.isi_jual.isi_jual_level_1 &&
        qty < notes.isi_jual.isi_jual_level_2
      ) {
        sub_total = hjlv_1 * qty
        jenis_harga = 'harga_jual_level_1'
        satuan_jual_nama = `${qty} ${await Units.getUnitName(
          satuan_jual_level_1
        )}`
        satuan_array.push({
          nama_unit: await Units.getUnitName(satuan_jual_level_1),
          unit_id: satuan_jual_level_1,
          level: 'harga_jual_level_1',
        })
      } else if (qty >= notes.isi_jual.isi_jual_level_2) {
        var pack = Math.floor(qty / isi_jual_level_2)
        var pcs = qty % isi_jual_level_2

        if (pack != 0 && pcs == 0) {
          sub_total = hjlv_2 * pack
          jenis_harga = 'harga_jual_level_2'
          satuan_jual_nama = `${pack} ${await Units.getUnitName(
            satuan_jual_level_2
          )}`
          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_2),
            unit_id: satuan_jual_level_2,
            level: 'harga_jual_level_2',
          })
        } else if (pack != 0 && pcs != 0) {
          sub_total = hjlv_2 * pack + hjlv_1 * pcs
          jenis_harga = 'harga_jual_level_2'
          satuan_jual_nama = `${pack} ${await Units.getUnitName(
            satuan_jual_level_2
          )}, ${pcs} ${await Units.getUnitName(satuan_jual_level_1)}`
          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_1),
            unit_id: satuan_jual_level_1,
            level: 'harga_jual_level_1',
          })
          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_2),
            unit_id: satuan_jual_level_2,
            level: 'harga_jual_level_2',
          })
        }
      }
    } else if (total_baris === 3) {
      hjlv_1 =
        cart_item?.nego_harga_level_1 == null
          ? notes.harga_jual.harga_jual_level_1
          : cart_item?.nego_harga_level_1
      hjlv_2 =
        cart_item?.nego_harga_level_2 == null
          ? notes.harga_jual.harga_jual_level_2
          : cart_item?.nego_harga_level_2
      hjlv_3 =
        cart_item?.nego_harga_level_3 == null
          ? notes.harga_jual.harga_jual_level_3
          : cart_item?.nego_harga_level_3

      if (
        qty >= notes.isi_jual.isi_jual_level_1 &&
        qty < notes.isi_jual.isi_jual_level_2
      ) {
        sub_total = hjlv_1 * qty
        jenis_harga = 'harga_jual_level_1'
        satuan_jual_nama = `${qty} ${await Units.getUnitName(
          satuan_jual_level_1
        )}`
        satuan_array.push({
          nama_unit: await Units.getUnitName(satuan_jual_level_1),
          unit_id: satuan_jual_level_1,
          level: 'harga_jual_level_1',
        })
      } else if (
        qty >= notes.isi_jual.isi_jual_level_2 &&
        qty < notes.isi_jual.isi_jual_level_3
      ) {
        var pack = Math.floor(qty / isi_jual_level_2)
        var pcs = qty % isi_jual_level_2

        if (pack != 0 && pcs == 0) {
          sub_total = hjlv_2 * pack
          jenis_harga = 'harga_jual_level_2'
          satuan_jual_nama = `${pack} ${await Units.getUnitName(
            satuan_jual_level_2
          )}`
          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_2),
            unit_id: satuan_jual_level_2,
            level: 'harga_jual_level_2',
          })
          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_1),
            unit_id: satuan_jual_level_1,
            level: 'harga_jual_level_1',
          })
        } else if (pack != 0 && pcs != 0 && pcs < isi_jual_level_2) {
          sub_total = hjlv_2 * pack + hjlv_1 * pcs
          jenis_harga = 'harga_jual_level_2'
          satuan_jual_nama = `${pack} ${await Units.getUnitName(
            satuan_jual_level_2
          )}, ${pcs} ${await Units.getUnitName(satuan_jual_level_1)}`
          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_2),
            unit_id: satuan_jual_level_2,
            level: 'harga_jual_level_2',
          })
          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_1),
            unit_id: satuan_jual_level_1,
            level: 'harga_jual_level_1',
          })
        }
      } else if (qty >= notes.isi_jual.isi_jual_level_3) {
        var pack = Math.floor(qty / isi_jual_level_3)
        var pcs = qty % isi_jual_level_3

        if (pack != 0 && pcs == 0) {
          sub_total = hjlv_3
          jenis_harga = 'harga_jual_level_3'
          satuan_jual_nama = `${pack} ${await Units.getUnitName(
            satuan_jual_level_3
          )}`
          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_3),
            unit_id: satuan_jual_level_3,
            level: 'harga_jual_level_3',
          })
        } else if (pack != 0 && pcs != 0 && pcs < isi_jual_level_2) {
          sub_total = hjlv_3 * pack + hjlv_1 * pcs
          jenis_harga = 'harga_jual_level_3'
          satuan_jual_nama = `${pack} ${await Units.getUnitName(
            satuan_jual_level_3
          )}, ${pcs} ${await Units.getUnitName(satuan_jual_level_1)}`
          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_1),
            unit_id: satuan_jual_level_1,
            level: 'harga_jual_level_1',
          })
          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_3),
            unit_id: satuan_jual_level_3,
            level: 'harga_jual_level_3',
          })
        } else if (pack != 0 && pcs != 0 && pcs >= isi_jual_level_2) {
          var pack_1 = Math.floor(pcs / isi_jual_level_2)
          var pcs_1 = pcs % isi_jual_level_2

          if (pack_1 != 0 && pcs_1 == 0) {
            sub_total = hjlv_3 * pack + hjlv_2 * pack_1
            jenis_harga = 'harga_jual_level_3'
            satuan_jual_nama = `${pack} ${await Units.getUnitName(
              satuan_jual_level_3
            )}, ${pack_1} ${await Units.getUnitName(satuan_jual_level_2)}`

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_2),
              unit_id: satuan_jual_level_2,
              level: 'harga_jual_level_2',
            })
            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_3),
              unit_id: satuan_jual_level_3,
              level: 'harga_jual_level_3',
            })
          } else {
            sub_total = hjlv_3 * pack + hjlv_2 * pack_1 + hjlv_1 * pcs_1
            jenis_harga = 'harga_jual_level_3'
            satuan_jual_nama = `${pack} ${await Units.getUnitName(
              satuan_jual_level_3
            )}, ${pack_1} ${await Units.getUnitName(
              satuan_jual_level_2
            )}, ${pcs_1} ${await Units.getUnitName(satuan_jual_level_1)}`

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_1),
              unit_id: satuan_jual_level_1,
              level: 'harga_jual_level_1',
            })
            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_2),
              unit_id: satuan_jual_level_2,
              level: 'harga_jual_level_2',
            })
            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_3),
              unit_id: satuan_jual_level_3,
              level: 'harga_jual_level_3',
            })
          }
        }
      }
    } else if (total_baris === 4) {
      hjlv_1 =
        cart_item?.nego_harga_level_1 == null
          ? notes.harga_jual.harga_jual_level_1
          : cart_item?.nego_harga_level_1
      hjlv_2 =
        cart_item?.nego_harga_level_2 == null
          ? notes.harga_jual.harga_jual_level_2
          : cart_item?.nego_harga_level_2
      hjlv_3 =
        cart_item?.nego_harga_level_3 == null
          ? notes.harga_jual.harga_jual_level_3
          : cart_item?.nego_harga_level_3
      hjlv_4 =
        cart_item?.nego_harga_level_4 == null
          ? notes.harga_jual.harga_jual_level_4
          : cart_item?.nego_harga_level_4

      if (
        qty >= notes.isi_jual.isi_jual_level_1 &&
        qty < notes.isi_jual.isi_jual_level_2
      ) {
        sub_total = hjlv_1 * qty
        jenis_harga = 'harga_jual_level_1'
        satuan_jual_nama = `${qty} ${await Units.getUnitName(
          satuan_jual_level_1
        )}`

        satuan_array.push({
          nama_unit: await Units.getUnitName(satuan_jual_level_1),
          unit_id: satuan_jual_level_1,
          level: 'harga_jual_level_1',
        })
      } else if (
        qty >= notes.isi_jual.isi_jual_level_2 &&
        qty < notes.isi_jual.isi_jual_level_3
      ) {
        var pack = Math.floor(qty / isi_jual_level_2)
        var pcs = qty % isi_jual_level_2

        if (pack != 0 && pcs == 0) {
          sub_total = hjlv_2 * pack
          jenis_harga = 'harga_jual_level_2'
          satuan_jual_nama = `${pack} ${await Units.getUnitName(
            satuan_jual_level_2
          )}`

          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_1),
            unit_id: satuan_jual_level_1,
            level: 'harga_jual_level_1',
          })
        } else if (pack != 0 && pcs != 0 && pcs < isi_jual_level_2) {
          sub_total = hjlv_2 * pack + hjlv_1 * pcs
          jenis_harga = 'harga_jual_level_2'
          satuan_jual_nama = `${pack} ${await Units.getUnitName(
            satuan_jual_level_2
          )}, ${pcs} ${await Units.getUnitName(satuan_jual_level_1)}`

          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_1),
            unit_id: satuan_jual_level_1,
            level: 'harga_jual_level_1',
          })
          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_2),
            unit_id: satuan_jual_level_2,
            level: 'harga_jual_level_2',
          })
        }
      } else if (
        qty >= notes.isi_jual.isi_jual_level_3 &&
        qty < notes.isi_jual.isi_jual_level_4
      ) {
        var pack = Math.floor(qty / isi_jual_level_3)
        var pcs = qty % isi_jual_level_3

        if (pack != 0 && pcs == 0) {
          sub_total = hjlv_3 * qty
          jenis_harga = 'harga_jual_level_3'
          satuan_jual_nama = `${pack} ${await Units.getUnitName(
            satuan_jual_level_3
          )}`
          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_3),
            unit_id: satuan_jual_level_3,
            level: 'harga_jual_level_3',
          })
        } else if (pack != 0 && pcs != 0 && pcs < isi_jual_level_2) {
          sub_total = hjlv_3 * pack + hjlv_1 * pcs
          jenis_harga = 'harga_jual_level_3'
          satuan_jual_nama = `${pack} ${await Units.getUnitName(
            satuan_jual_level_3
          )}, ${pcs} ${await Units.getUnitName(satuan_jual_level_1)}`

          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_3),
            unit_id: satuan_jual_level_3,
            level: 'harga_jual_level_3',
          })
          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_1),
            unit_id: satuan_jual_level_1,
            level: 'harga_jual_level_1',
          })
        } else if (pack != 0 && pcs != 0 && pcs >= isi_jual_level_2) {
          var pack_1 = Math.floor(pcs / isi_jual_level_2)
          var pcs_1 = pcs % isi_jual_level_2

          if (pack_1 != 0 && pcs_1 == 0) {
            sub_total = hjlv_3 * pack + hjlv_2 * pcs
            jenis_harga = 'harga_jual_level_3'
            satuan_jual_nama = `${pack} ${await Units.getUnitName(
              satuan_jual_level_3
            )}, ${pack_1} ${await Units.getUnitName(satuan_jual_level_2)}`

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_2),
              unit_id: satuan_jual_level_2,
              level: 'harga_jual_level_2',
            })
            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_3),
              unit_id: satuan_jual_level_3,
              level: 'harga_jual_level_3',
            })
          } else {
            sub_total = hjlv_3 * pack + hjlv_2 * pack_1 + hjlv_1 * pcs_1
            jenis_harga = 'harga_jual_level_3'
            satuan_jual_nama = `${pack} ${await Units.getUnitName(
              satuan_jual_level_3
            )}, ${pack_1} ${await Units.getUnitName(
              satuan_jual_level_2
            )}, ${pcs_1} ${await Units.getUnitName(satuan_jual_level_1)}`

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_1),
              unit_id: satuan_jual_level_1,
              level: 'harga_jual_level_1',
            })
            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_2),
              unit_id: satuan_jual_level_2,
              level: 'harga_jual_level_2',
            })
            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_3),
              unit_id: satuan_jual_level_3,
              level: 'harga_jual_level_3',
            })
          }
        }
      } else if (qty >= notes.isi_jual.isi_jual_level_4) {
        hjlv_1 =
          cart_item?.nego_harga_level_1 == null
            ? notes.harga_jual.harga_jual_level_1
            : cart_item?.nego_harga_level_1
        hjlv_2 =
          cart_item?.nego_harga_level_2 == null
            ? notes.harga_jual.harga_jual_level_2
            : cart_item?.nego_harga_level_2
        hjlv_3 =
          cart_item?.nego_harga_level_3 == null
            ? notes.harga_jual.harga_jual_level_3
            : cart_item?.nego_harga_level_3
        hjlv_4 =
          cart_item?.nego_harga_level_4 == null
            ? notes.harga_jual.harga_jual_level_4
            : cart_item?.nego_harga_level_4

        var pack = Math.floor(qty / isi_jual_level_4)
        var pcs = qty % isi_jual_level_4

        if (pack != 0 && pcs == 0) {
          sub_total = hjlv_1 * qty
          jenis_harga = 'harga_jual_level_4'
          satuan_jual_nama = `${pack} ${await Units.getUnitName(
            satuan_jual_level_4
          )}`

          satuan_array.push({
            nama_unit: await Units.getUnitName(satuan_jual_level_4),
            unit_id: satuan_jual_level_4,
            level: 'harga_jual_level_4',
          })
        } else if (
          pack != 0 &&
          pcs != 0 &&
          pcs > isi_jual_level_2 &&
          pcs < isi_jual_level_3
        ) {
          pack_1 = Math.floor(pcs / isi_jual_level_2)
          pcs_1 = pcs % isi_jual_level_2

          if (pack_1 != 0 && pcs_1 == 0) {
            sub_total = hjlv_4 * pack + hjlv_4 * pack_1
            jenis_harga = 'harga_jual_level_4'
            satuan_jual_nama = `${pack} ${await Units.getUnitName(
              satuan_jual_level_4
            )}, ${pack_1} ${await Units.getUnitName(satuan_jual_level_2)}`

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_2),
              unit_id: satuan_jual_level_2,
              level: 'harga_jual_level_2',
            })
            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_4),
              unit_id: satuan_jual_level_4,
              level: 'harga_jual_level_4',
            })
          } else if (pack_1 != 0 && pcs_1 != 0) {
            sub_total =
              hjlv_4 * pack +
              notes.harga_jual.harga_jual_level_2 * pack_1 +
              hjlv_1 * pcs_1
            jenis_harga = 'harga_jual_level_4'

            satuan_jual_nama = `${pack} ${await Units.getUnitName(
              satuan_jual_level_4
            )}, ${pack_1} ${await Units.getUnitName(
              satuan_jual_level_2
            )}, ${pcs_1} ${await Units.getUnitName(satuan_jual_level_1)}`

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_4),
              unit_id: satuan_jual_level_4,
              level: 'harga_jual_level_4',
            })
            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_2),
              unit_id: satuan_jual_level_2,
              level: 'harga_jual_level_2',
            })
            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_1),
              unit_id: satuan_jual_level_1,
              level: 'harga_jual_level_1',
            })
          }
        } else if (
          pack != 0 &&
          pcs != 0 &&
          pcs > isi_jual_level_2 &&
          pcs > isi_jual_level_3
        ) {
          var pack_1 = Math.floor(pcs / isi_jual_level_3)
          var pcs_1 = pcs % isi_jual_level_3

          if (pack_1 != 0 && pcs_1 == 0) {
            sub_total = hjlv_4 * pack + hjlv_2 * pack_1
            jenis_harga = 'harga_jual_level_4'
            satuan_jual_nama = `${pack} ${await Units.getUnitName(
              satuan_jual_level_4
            )}, ${pack_1} ${await Units.getUnitName(satuan_jual_level_2)}`

            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_4),
              unit_id: satuan_jual_level_4,
              level: 'harga_jual_level_4',
            })
            satuan_array.push({
              nama_unit: await Units.getUnitName(satuan_jual_level_2),
              unit_id: satuan_jual_level_2,
              level: 'harga_jual_level_2',
            })
          } else if (pack_1 != 0 && pcs_1 != 0) {
            var pack_2 = Math.floor(pcs_1 / isi_jual_level_2)
            var pcs_2 = pcs_1 % isi_jual_level_2

            if (pack_2 != 0 && pcs_2 == 0) {
              sub_total = hjlv_4 * pack + hjlv_3 * pack_1 + hjlv_1 * pcs_1
              jenis_harga = 'harga_jual_level_4'
              satuan_jual_nama = `${pack} ${await Units.getUnitName(
                satuan_jual_level_4
              )}, ${pack_1} ${await Units.getUnitName(
                satuan_jual_level_3
              )}, ${pack_2} ${await Units.getUnitName(satuan_jual_level_1)}`

              satuan_array.push({
                nama_unit: await Units.getUnitName(satuan_jual_level_4),
                unit_id: satuan_jual_level_4,
                level: 'harga_jual_level_4',
              })
              satuan_array.push({
                nama_unit: await Units.getUnitName(satuan_jual_level_3),
                unit_id: satuan_jual_level_3,
                level: 'harga_jual_level_3',
              })
              satuan_array.push({
                nama_unit: await Units.getUnitName(satuan_jual_level_1),
                unit_id: satuan_jual_level_1,
                level: 'harga_jual_level_1',
              })
            } else if (pack_2 != 0 && pcs_2 != 0) {
              sub_total =
                hjlv_4 * pack +
                hjlv_3 * pack_1 +
                hjlv_2 * pack_2 +
                hjlv_1 * pcs_2
              jenis_harga = 'harga_jual_level_4'
              satuan_jual_nama = `${pack} ${await Units.getUnitName(
                satuan_jual_level_4
              )}, ${pack_1} ${await Units.getUnitName(
                satuan_jual_level_3
              )}, ${pack_2} ${await Units.getUnitName(
                satuan_jual_level_2
              )}, ${pcs_2} ${await Units.getUnitName(satuan_jual_level_1)}`

              satuan_array.push({
                nama_unit: await Units.getUnitName(satuan_jual_level_4),
                unit_id: satuan_jual_level_4,
                level: 'harga_jual_level_4',
              })
              satuan_array.push({
                nama_unit: await Units.getUnitName(satuan_jual_level_3),
                unit_id: satuan_jual_level_3,
                level: 'harga_jual_level_3',
              })
              satuan_array.push({
                nama_unit: await Units.getUnitName(satuan_jual_level_2),
                unit_id: satuan_jual_level_2,
                level: 'harga_jual_level_2',
              })
              satuan_array.push({
                nama_unit: await Units.getUnitName(satuan_jual_level_1),
                unit_id: satuan_jual_level_1,
                level: 'harga_jual_level_1',
              })
            }
          }
        }
      }
    }

    result = {
      satuan_jual_nama,
      sub_total,
      jenis_harga,
      jumlah,
      hjlv_1,
      hjlv_2,
      hjlv_3,
      hjlv_4,
      satuan_array,
      notes,
    }
  } else {
    result = {}
  }
  return result
}

exports.filteredObj = (object) => {
  Object.entries(object).forEach(([k, v]) => {
    if (v && typeof v === 'object') {
      this.filteredObj(v)
    }
    if (
      (v && typeof v === 'object' && !Object.keys(v).length) ||
      v === null ||
      v === undefined ||
      v === 0
    ) {
      if (Array.isArray(object)) {
        object.splice(k, 1)
      } else {
        delete object[k]
      }
    }
  })
  return object
}
