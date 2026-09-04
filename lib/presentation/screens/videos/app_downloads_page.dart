// screens/history_screen.dart
import 'package:click_yt/domain/entities/download_task.dart';
import 'package:click_yt/presentation/providers/download_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDownloadsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Download History'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete_sweep,
              semanticLabel: 'Delete History',
            ),
            onPressed: () {
              _showClearDialog(context);
            },
          ),
        ],
      ),
      body: Consumer<DownloadProvider>(
        builder: (context, provider, child) {
          if (provider.tasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 64,
                    color: Colors.grey.shade400,
                    semanticLabel: 'history Icon',
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Downloads on History',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.tasks.length,
            itemBuilder: (context, index) {
              final task = provider.tasks[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ExpansionTile(
                  leading: Icon(
                    _getStatusIcon(task.status),
                    color: _getStatusColor(task.status),
                  ),
                  title: Text(
                    task.videoTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${task.quality} • ${_formatDate(task.createdAt)}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      if (task.status == DownloadStatus.completed)
                        Text(
                          'Completado: ${_formatDate(task.completedAt!)}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.green,
                          ),
                        ),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Detalles
                          _buildDetailRow(
                            'Status',
                            _getStatusText(task.status),
                          ),
                          _buildDetailRow('Quality', task.quality),
                          if (task.progress > 0)
                            _buildDetailRow(
                              'Progress',
                              '${(task.progress * 100).toStringAsFixed(1)}%',
                            ),
                          if (task.filePath != null)
                            _buildDetailRow('Location', task.filePath!),
                          if (task.errorMessage != null)
                            _buildDetailRow('Error', task.errorMessage!),

                          const SizedBox(height: 8),

                          // Botones de acción
                          if (task.status == DownloadStatus.completed)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton.icon(
                                  onPressed: () {
                                    // Abrir archivo
                                    _openFile(task.filePath!);
                                  },
                                  icon: const Icon(Icons.folder_open),
                                  label: const Text('Open'),
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),

                          if (task.status == DownloadStatus.failed)
                            TextButton.icon(
                              onPressed: () {
                                // Reintentar descarga
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text('Retry'),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: TextStyle(color: Colors.grey.shade800)),
          ),
        ],
      ),
    );
  }

  void _showClearDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpiar Historial'),
        content: const Text(
          '¿Estás seguro de que quieres eliminar todo el historial?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<DownloadProvider>(
                context,
                listen: false,
              ).clearHistory();
              Navigator.pop(context);
            },
            child: const Text(
              'Limpiar',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _openFile(String filePath) {
    // Implementar apertura de archivo
  }

  IconData _getStatusIcon(DownloadStatus status) {
    switch (status) {
      case DownloadStatus.completed:
        return Icons.check_circle;
      case DownloadStatus.failed:
        return Icons.error;
      case DownloadStatus.downloading:
        return Icons.downloading;
      default:
        return Icons.pending;
    }
  }

  Color _getStatusColor(DownloadStatus status) {
    switch (status) {
      case DownloadStatus.completed:
        return Colors.green;
      case DownloadStatus.failed:
        return Colors.red;
      case DownloadStatus.downloading:
        return Colors.blue;
      default:
        return Colors.orange;
    }
  }

  String _getStatusText(DownloadStatus status) {
    switch (status) {
      case DownloadStatus.completed:
        return 'Completado';
      case DownloadStatus.failed:
        return 'Fallido';
      case DownloadStatus.downloading:
        return 'Descargando';
      case DownloadStatus.pending:
        return 'Pendiente';
      case DownloadStatus.paused:
        return 'Pausado';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
