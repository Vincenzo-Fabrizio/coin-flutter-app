# 🪙 Coin Flutter App

> Un’app Flutter per gestire, catalogare e visualizzare la tua collezione numismatica, con statistiche e quotazioni in tempo reale.

---

## 📋 Descrizione

**Coin Flutter App** è un’applicazione mobile sviluppata in Flutter pensata per collezionisti di monete.  
Permette di:
- aggiungere monete alla propria collezione,
- visualizzare dettagli completi,
- consultare la rarità e lo stato di conservazione,
- vedere le quotazioni dell’oro aggiornate in tempo reale con grafici.

L’app offre un’interfaccia moderna e semplice, con gestione dei dati in locale.

---

## 🎨 Funzionalità principali

✅ **Gestione della collezione**
- Aggiungi monete con: nome, anno, materiale, peso, dimensioni, prezzo, rarità e conservazione.
- Visualizza i dettagli completi di ogni moneta.
- Elimina facilmente le monete dalla collezione.
- Lista ordinata con swipe-to-delete.

✅ **Ricerca**
- Filtra le monete in base a criteri personalizzati.
- Ricerca rapida all’interno della collezione.

✅ **Quotazioni in tempo reale**
- Prezzo corrente dell’oro (24K e 22K) in €/g.
- Grafico storico delle quotazioni degli ultimi giorni.

✅ **Design moderno**
- Interfaccia responsive.
- Navigazione fluida con PageView e AppBar personalizzata.

✅ **Test**
- Copertura di unit test e widget test per garantire stabilità e correttezza.

---

## 🛠️ Tecnologie utilizzate

- [Flutter](https://flutter.dev/)
- [Dart](https://dart.dev/)
- [Hive](https://docs.hivedb.dev/) — persistenza locale
- [fl_chart](https://pub.dev/packages/fl_chart) — grafici
- [flutter_test](https://docs.flutter.dev/cookbook/testing/unit/introduction) — test automatizzati

---

## 📦 Build & esecuzione

### Requisiti
- Flutter ≥ 3.x
- SDK Android/iOS
- Emulatore o dispositivo reale

### Comandi utili
```bash
flutter pub get            # installa le dipendenze
flutter run                # avvia l’app
flutter test               # esegui i test
flutter build apk          # genera un APK per Android
flutter build appbundle    # genera un AAB per il Play Store
